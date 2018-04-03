# Haoji Liu
import sys
import time
import datetime
import threading

import zmq

import constants
import util

from pymongo import MongoClient
client = MongoClient()
client = MongoClient('localhost', 27017)
db = client.main_db
weather_data = db['weather_data']

read_host = util.try_get_ip(constants.zmq_read_host)
write_host = util.try_get_ip(constants.zmq_write_host)

def connect_read_port(context):
  # to get read requests
  read_sock = context.socket(zmq.REP)
  connect_string = 'tcp://{}:{}'.format(
      read_host, constants.read_worker_port)
  print('read addr is %s' % connect_string)
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
  print('write addr is %s' % connect_string)
  return write_sock

def read(sock):
  while True:
    print('waiting for read requests...')
    data =sock.recv_json()
    print(data)
    # TODO: filter by time period instead of returning all
    cursor = weather_data.find({})
    resp = [doc['station'] for doc in cursor]
    print(resp)
    # resp = mydb.mytable.find({"date": {"$lt": datetime.datetime(2015, 12, 1)}}).sort("author")
    sock.send_json({
      'raw': resp
    })
    time.sleep(3)

def _write(data_dict):
  weather_data.insert_one(data_dict)

def write(sock):
  """Each message received will be one entry in the db"""
  while True:
    print('waiting for write requests...')
    data = sock.recv_json()
    ts = time.time()
    current_timestamp = datetime.datetime.fromtimestamp(ts).strftime('%Y-%m-%d %H:%M:%S')

    raw = data.get('raw', 'placeholder write data from db node itself...')
    timestamp_utc = data['timestamp_utc']
    for line in raw.splitlines():
      print('Going to write the following station to the db node: %s' % line)
      # db.data.insert({
      #     "station": // station name
      #     "timestamp_utc": // the weather data were gathered at
      #     "raw": // all columns except the station column
      #     "created_at_utc": // this row is inserted at
      #   })

      _write({
        'station': 'ACT',
        'timestamp_utc': timestamp_utc,
        'raw': line,
        'created_at_utc': current_timestamp
      })

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
    print(e)
  finally:
    read_sock.close()
    write_sock.close()

if __name__ == '__main__':
  main()
