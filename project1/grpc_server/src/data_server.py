import time
import grpc
import data_pb2
import data_pb2_grpc

import json
import os, logging, sys

######################################
# TODO: move all the crap below to another file
_log = logging.getLogger(__name__)
# _log.setLevel(logging.DEBUG)
# ch = logging.StreamHandler(sys.stdout)
# ch.setLevel(logging.DEBUG)
# formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
# ch.setFormatter(formatter)
# _log.addHandler(ch)

import zmq
import constants, util

zmq_context = zmq.Context()

write_host = util.try_get_ip(constants.zmq_write_host)
read_host = util.try_get_ip(constants.zmq_read_host)

write_connect_string = 'tcp://{}:{}'.format(
    write_host, constants.write_port)

read_connect_string = 'tcp://{}:{}'.format(
    read_host, constants.read_client_port)

def get_write_socket():
  write_sock = zmq_context.socket(zmq.PUB)

  write_sock.bind(write_connect_string)
  # TODO: try not rebind with every grpc call, let's do a timeout of 4 hour or something
  time.sleep(1) # this is needed so that we talk after the bind is complete!
  print('write socket connected to %s' % write_connect_string)

  return write_sock

def get_read_socket():
  # Open a new socket per request
  read_client_sock = zmq_context.socket(zmq.REQ)
  read_client_sock.setsockopt(zmq.LINGER, 100)
  # 10 sec read timeout
  read_client_sock.setsockopt(zmq.RCVTIMEO, 1000)

  print('read socket connecting to %s' % read_connect_string)
  read_client_sock.connect(read_connect_string)
  return read_client_sock

def read(sock, params):
  # TODO: add more params like table name, target station
  print('trying to send a req to read socket...')
  print(sock)
  sock.send_json(params)
  # wait for response
  print('waiting for read response...')
  return sock.recv_multipart()

def try_read(params):
  read_client_sock = None
  try:
    read_client_sock = get_read_socket()
    for r in read(read_client_sock, params):
      yield r
  except Exception as e:
    print(e)
    return {'msg': 'something wrong with read...'}
  finally:
    # Make sure it's closed
    if read_client_sock:
      # print('closing the read socket...')
      read_client_sock.disconnect(read_connect_string)
      read_client_sock.close()

### TODO: should we have a separate peek socket????
def pre_read_check():
  # TODO: if we don't have it, send query to other clusters
  return True

def pre_write_check():
  # TODO: if we can't handle the data, send data to other clusters
  return True
###

def write(payload):
  write_sock = None
  try:
    write_sock = get_write_socket()
    write_sock.send_json(payload)
  except Exception as e:
    print('something wrong with write...')
    print(e)
  finally:
    # Make sure it's closed
    if write_sock:
      print('closing the write socket...')
      write_sock.disconnect(write_connect_string)
      write_sock.close()

  return True

class DataServer(data_pb2_grpc.CommunicationServiceServicer):
  # def __init__(self, read_sock, write_sock):
  #   self.read_sock = read_sock
  #   self.write_sock = write_sock
  def PutHandler(self, request_iterator, context):
    print('this is a put request')
    if pre_write_check():
      for request in request_iterator:
        assert request.putRequest.metaData.uuid is not None
        payload = {
          'raw': request.putRequest.datFragment.data.decode(),
          'timestamp_utc': request.putRequest.datFragment.timestamp_utc,
          'uuid': request.putRequest.metaData.uuid}
        write(payload)
      return data_pb2.Response(
        code=data_pb2.StatusCode.Value('Ok'),
        msg="put data successfully the grpc server!")
    else:
      return data_pb2.Response(
        code=data_pb2.StatusCode.Value('Failed'),
        msg="this node is full")

  def GetHandler(self, request, context):
    assert request.getRequest.metaData.uuid is not None
    params = {
      'from_utc': request.getRequest.queryParams.from_utc,
      'to_utc': request.getRequest.queryParams.to_utc,
    }
    print('this is a get request with params %s' % str(params))
    if pre_read_check(params):
      for datFrag in try_read(params):
        yield data_pb2.Response(
          code=data_pb2.StatusCode.Value('Ok'),
          msg="get data successfully from the grpc server!",
          datFragment=data_pb2.DatFragment(data=datFrag))
    else:
      yield data_pb2.Response(
        code=data_pb2.StatusCode.Value('Failed'),
        msg="We don't have it!")

  def ping(self, request, context):
    print('this is a ping request')
    return data_pb2.Response(
      code=data_pb2.StatusCode.Value('Ok'),
      msg="pinged successfully the grpc server!")
