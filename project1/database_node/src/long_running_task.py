# Haoji Liu
import sys
import time
import datetime
import threading
import logging

import zmq

import constants
import util

from pymongo import MongoClient
client = MongoClient()
client = MongoClient('localhost', 27017)
db = client.main_db
weather_data = db['weather_data']
# weather_data.remove({})
read_host = util.try_get_ip(constants.zmq_read_host)
write_host = util.try_get_ip(constants.zmq_write_host)

def connect_read_port(context):
  # to get read requests
  read_sock = context.socket(zmq.REP)
  connect_string = 'tcp://{}:{}'.format(
      read_host, constants.read_worker_port)
  logging.warning('read addr is %s' % connect_string)
  read_sock.connect(connect_string)
  time.sleep(1)
  return read_sock

def connect_write_port(context):
  # to get write requests
  write_sock = context.socket(zmq.SUB)
  connect_string = 'tcp://{}:{}'.format(
      write_host, constants.write_port)
  write_sock.connect(connect_string)
  write_sock.setsockopt(zmq.SUBSCRIBE, b"")
  time.sleep(1)
  logging.warning('write addr is %s' % connect_string)
  return write_sock

def serialize(doc):
  """convert mongodb bson doc into a string

  Returns byte string
  """
  logging.warning(doc)
  return ' '.join([doc['timestamp_utc'], doc['raw']]).encode()

def read(sock):
  while True:
    logging.warning('waiting for read requests...')
    params =sock.recv_json()
    logging.warning(params)
    cursor = weather_data.find({})
    parts = [serialize(doc) for doc in cursor]
    # resp = mydb.mytable.find({"date": {"$lt": datetime.datetime(2015, 12, 1)}}).sort("author")
    logging.warning('sending reading results back... %s' % str(parts))
    # TODO: sending in chunks of lines, not line by line
    sock.send_multipart(parts)
    #for part in parts:
    # sock.send(parts[0].encode())
    time.sleep(3)

def _write(data_dict):
  weather_data.insert_one(data_dict)

def sanitize(line):
  """remove extra spaces, tabs, trailing/leading spaces, etc."""
  return line.strip()

def deserialize(line):
  station = line.split(' ')[0]
  return {'station': station, 'raw': line}

def write(sock):
  """Each message received will be one entry in the db"""
  while True:
    logging.warning('waiting for write requests...')
    data = sock.recv_json()
    ts = time.time()
    current_timestamp = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')

    raw = data.get('raw', 'placeholder write data from db node itself...')
    timestamp_utc = data['timestamp_utc']
    uuid = data['uuid']
    for line in raw.splitlines():
      logging.warning('Going to write the following station to the db node: %s' % line)
      line = sanitize(line)
      logging.warning('Going to write the following station to the db node: %s' % line)
      # db.data.insert({
      #     "station": // station name
      #     "timestamp_utc": // the weather data were gathered at
      #     "raw": // all columns except the station column
      #     "created_at_utc": // this row is inserted at
      #   })
      d = deserialize(line)
      d['timestamp_utc'] = timestamp_utc
      d['created_at_utc'] = current_timestamp
      d['uuid'] = uuid
      _write(d)

def main():
  # TODO: implement a retry context manager
  try:
    # ZeroMQ Context
    context = zmq.Context()
    read_sock = connect_read_port(context)
    write_sock = connect_write_port(context)
    write_thread = threading.Thread(target=write, args=(write_sock,))
    write_thread.daemon = True
    write_thread.start()

    read_thread = threading.Thread(target=read, args=(read_sock,))
    read_thread.daemon = True
    read_thread.start()

    read_thread.join()
    write_thread.join()
  except Exception as e:
    logging.warning(e)
  finally:
    read_sock.close()
    write_sock.close()

if __name__ == '__main__':
  main()
