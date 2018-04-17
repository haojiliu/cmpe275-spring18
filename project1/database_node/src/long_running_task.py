# Haoji Liu
import sys, os
import time
import datetime
import threading
import logging
import hashlib

import zmq

import constants
import util

from pymongo import MongoClient
client = MongoClient()
client = MongoClient('localhost', 27017)
db = client.main_db
weather_data = db['weather_data']

# mesowest = db['mesowest']
# mesonet = db['mesonet']

# TODO: for test only
# mesowest.remove({})
# mesonet.remove({})

# TODO: update schema
# SCHEMA:
# db.data.insert({
#     "uuid": // defined by the grpc client
#     "station": // station name
#     "timestamp_utc": // the weather data were gathered at
#     "raw": // all columns except the station column
#     "created_at_utc": // this row is inserted at
#   })
read_host = util.try_get_ip(constants.zmq_read_host)
write_host = util.try_get_ip(constants.zmq_write_host)

CONST_DB_LOWER_BOUND = 1 * 1024 * 1024 # 1 MB

CONST_TIMESTAMP_FMT = '%Y-%m-%d %H:%M:%S'

CONST_STD_COL_LIST = 'STN YYMMDD/HHMM MNET SLAT SLON SELV TMPF SKNT DRCT GUST PMSL ALTI DWPF RELH WTHR P24I'.split()
CONST_NUM_OF_COLS = len(CONST_STD_COL_LIST)

CONST_DELIMITER = ','

def is_disk_full():
  """
  Re-route to other clusters if disk full here
  Returns: True if disk full
  """
  logging.warning('available space %s' % os.statvfs('/data/db').f_bavail)
  val = os.statvfs('/data/db').f_bavail < CONST_DB_LOWER_BOUND
  logging.warning(val)
  return val

def get_cursor(target, params):
  """
  Returns: mongodb cursor object
  """
  # these are in the format of '2016-18-19 12:12:12'
  from_utc = params['from_utc']
  to_utc = params['to_utc']

  start = datetime.datetime.strptime(from_utc, CONST_TIMESTAMP_FMT)
  end = datetime.datetime.strptime(to_utc, CONST_TIMESTAMP_FMT)

  cursor = target.find({
    'timestamp_utc': {
        '$gte': start,
        '$lt': end
    }
  })
  return cursor

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
  return doc['raw'].encode()

def read(sock):
  while True:
    try:
      logging.warning('waiting for read requests...')
      params =sock.recv_json()
      logging.warning(params)
      # if it's a pre check for write
      if 'pre_write_check' in params:
        val = is_disk_full()
        sock.send_multipart([str(val).encode(),])
        continue

      cursor = get_cursor(weather_data, params)
      parts = [serialize(doc) for doc in cursor]
      if not parts:
        # This is to bypass zmq, empty list throws error
        parts = ['No Result'.encode(),]
      logging.warning('sending reading results back... %s' % str(parts))
      sock.send_multipart(parts)

      # TODO: sending in chunks of lines, not line by line
      # TODO: do we really need to sleep here???
      time.sleep(1)
    except Exception as e:
      logging.warning(e)

def sanitize(line):
  """remove extra spaces, tabs, trailing/leading spaces, etc."""
  return line.strip()

def deserialize(line):
  """split a line int columns"""
  cols = line.split(CONST_DELIMITER)
  logging.warning(cols)

  assert len(cols) == CONST_NUM_OF_COLS
  logging.warning('hey deserialize...')

  station = cols[0]
  ts = cols[1]

  d = {
    'station': station,
    'raw': line,
    'timestamp_utc': datetime.datetime.strptime(ts, CONST_TIMESTAMP_FMT),
    'created_at_utc': datetime.datetime.now(),
    'hash': get_hash(line)
  }

  # Adding all columns
  for idx, val in enumerate(CONST_STD_COL_LIST):
    d[val] = cols[idx]

  return d

def get_hash(s):
  return hashlib.sha224(s.encode()).hexdigest()

def _write(data_dict, target_collection):
  if not target_collection.find_one({'hash': data_dict['hash']}):
    logging.warning('new entry, going to write to db...')
    target_collection.insert_one(data_dict)
  else:
    logging.warning('existed!! ignore this write')

def write(sock):
  """Each message received will be one entry in the db"""
  while True:
    logging.warning('waiting for write requests...')
    data = sock.recv_json()
    raw = data.get('raw', 'placeholder write data from db node itself...')
    uuid = data['uuid']

    for line in raw.splitlines():
      try:
        line = sanitize(line)
        # invalid data
        if not line:
          continue
        d = deserialize(line)
        d['uuid'] = uuid
      except:
        logging.warning('something wrong with writing this line %s' % line)
        logging.exception()
        continue
      # if nothing wrong, write this line
      logging.warning('Going to write the following station to the db node: %s' % d)
      _write(d, weather_data)
    logging.warning('Write succeeded...')

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
