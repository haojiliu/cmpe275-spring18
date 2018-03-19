# Haoji Liu
import sys
import time
import threading

import zmq

zmq_read_host = 'cmpe275_task_scheduler'
zmq_read_host = '172.18.0.3'
zmq_write_host = 'cmpe275_web'
zmq_write_host = '172.18.0.4'
read_worker_port = 5560
write_port = 8081

from pymongo import MongoClient
client = MongoClient()
client = MongoClient('localhost', 27017)
db = client.main_db

def connect_read_port(context):
  # to get read requests
  read_sock = context.socket(zmq.REP)
  connect_string = 'tcp://{}:{}'.format(
      zmq_read_host, read_worker_port)
  print('read addr is %s' % connect_string)
  read_sock.connect(connect_string)
  return read_sock

def connect_write_port(context):
  # to get write requests
  write_sock = context.socket(zmq.SUB)
  connect_string = 'tcp://{}:{}'.format(
      zmq_write_host, write_port)
  print('write addr is %s' % connect_string)
  write_sock.connect(connect_string)
  write_sock.setsockopt(zmq.SUBSCRIBE, b"")
  return write_sock

def read(sock):
  while True:
    print('waiting for read requests...')
    data =sock.recv_json()
    raw = data.get('raw', 'sample read data')
    print(raw)
    time.sleep(3)
    sock.send(b'Query result: Some sample read data')
    # for post in mydb.mytable.find({"date": {"$lt": datetime.datetime(2015, 12, 1)}}).sort("author"):
    # ...    post

def _write(data_dict):
  db.weather.insert_one(data_dict)

def write(sock):
  """Each message received will be one entry in the db"""
  while True:
    print('waiting for write requests...')
    data = sock.recv_json()
    raw = data.get('station', 'placeholder write data from db node itself...')
    print('Going to write the following to the db node: %s' % raw)
    # db.data.insert({
    #     "station": // station name
    #     "timestamp_utc": // the weather data were gathered at
    #     "raw": // all columns except the station column
    #     "created_at_utc": // this row is inserted at
    #   })
    _write(data)
    time.sleep(3)

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
