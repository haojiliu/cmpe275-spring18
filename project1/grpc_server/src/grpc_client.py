# Haoji Liu
# This is the grpc client, that will read a data file, chunk it into several messages, and send it to grpc server
# Haoji Liu
import uuid, time, argparse
import grpc
import data_pb2_grpc
from data_pb2 import Request, Response, PingRequest, PutRequest, GetRequest, DatFragment, MetaData, QueryParams

CONST_MEDIA_TYPE_TEXT = 1

# Looks like 1KB is a good chunk size
CONST_CHUNK_SIZE = 10  # number of lines per payload

def preprocess(fpath):
  """read file and chunkify it to be small batch for grpc transport

  Returns: a string, concat of data rows, separated by newline char
  """
  # TODO: get the actual timestamp from the data
  timestamp_utc = '2016-03-12 03:23:47'
  buffer = []
  with open(fpath) as f:
    for line in f:
      if len(buffer) == CONST_CHUNK_SIZE:
        res = ''.join(buffer)
        buffer = []
        yield timestamp_utc, res
      else:
        # we can't call strip() here as it will remove the newline char
        buffer.append(line)
    # last batch
    if buffer:
      yield timestamp_utc, ''.join(buffer)

def put_req_iterator(fpath, sender, receiver):
  my_uuid = str(uuid.uuid1())
  for timestamp_utc, raw in preprocess(fpath):
    yield Request(
      fromSender=sender,
      toReceiver=receiver,
      putRequest=PutRequest(
          metaData=MetaData(uuid=my_uuid, mediaType=CONST_MEDIA_TYPE_TEXT),
          datFragment=DatFragment(timestamp_utc=timestamp_utc, data=raw.encode()))
      )

class Client():
  def __init__(self, host, port, sender):
    assert sender is not None, 'sender has to be specified'
    self.channel = grpc.insecure_channel('%s:%d' % (host, port))
    self.stub = data_pb2_grpc.CommunicationServiceStub(self.channel)
    self.sender = sender
    self.receiver = host

  def ping(self, msg):
    req = Request(
      fromSender=self.sender,
      toReceiver=self.receiver,
      ping=PingRequest(msg=msg))
    resp = self.stub.Ping(req)
    return resp.msg

  def put(self, fpath):
    req_iterator = put_req_iterator(fpath, self.sender, self.receiver)
    resp = self.stub.PutHandler(req_iterator)
    print(resp.msg)
    return True

  def get(self, from_utc, to_utc):
    req = Request(
      fromSender=self.sender,
      toReceiver=self.receiver,
      getRequest=GetRequest(
          metaData=MetaData(uuid='14829'),
          queryParams=QueryParams(from_utc=from_utc,to_utc=to_utc))
      )
    for resp in self.stub.GetHandler(req):
      print(resp.datFragment.data)

def main():
  """
  Sample Usage:
  get: -H 0.0.0.0 -P 8080 -g '2016-07-08 10:00:00' '2016-07-08 10:00:00'
  put: -H 0.0.0.0 -P 8080 -p -f './201803180010.mdf'
  ping: -H 0.0.0.0 -P 8080 -m 'hello world!'
  """
  # for timestamp_utc, raw in preprocess('./201803180010.mdf'):
  #   print(raw)
  # return True
  #

  parser = argparse.ArgumentParser(description='Weather Data Lake Python API v1.0')
  parser.add_argument('-H', '--host', type=str, default='0.0.0.0', help='The host of the grpc server')
  parser.add_argument('-P', '--port', type=int, default=8080, help='The port listened by grpc server')
  parser.add_argument('-f', '--file', type=str, default='./201803180010.mdf', help='The file path to upload')
  parser.add_argument('-g', '--get', action='store_true', default=False, help='-g -t <from_utc> <to_utc>')
  parser.add_argument('-u', '--upload', action='store_true', default=False, help='Upload data to the server')
  parser.add_argument('-p', '--ping', action='store_true', default=False, help='Ping the server')
  parser.add_argument('-t', '--range', type=str, nargs=2, help='-t <from_utc> <to_utc>')
  parser.add_argument('-s', '--stations', nargs='*', help='-s <station1> <station2> <...>')
  parser.add_argument('-m', '--message', type=str, default='Hello World!', help='-m "Hello World!"')

  args = parser.parse_args()
  print(args)
  try:
    host = args.host
    port = args.port
    assert host
    assert port
    client = Client(host, port, 'some sender')
    if args.get:
      assert args.range
      from_utc, to_utc = args.range[0], args.range[1]
      assert from_utc
      assert to_utc
      client.get(from_utc=from_utc, to_utc=to_utc)

    elif args.upload:
      fp = args.file
      assert fp
      client.put(fpath=fp)

    elif args.ping:
      print(client.ping(msg=args.message))
  except Exception as e:
    print(e)
    parser.print_help()


if __name__ == '__main__':
  main()
