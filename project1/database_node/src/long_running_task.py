# Haoji Liu
import sys
import time
import threading

import zmq

zmq_read_host = 'cmpe275_task_scheduler'
zmq_write_host = 'cmpe275_web'
read_worker_port = 5560
write_port = 8081

def bind_read_port(context):
  # to get read requests
  read_sock = context.socket(zmq.REP)
  connect_string = 'tcp://{}:{}'.format(
      zmq_read_host, read_worker_port)
  read_sock.connect(connect_string)
  return read_sock

def bind_write_port(context):
  # to get write requests
  write_sock = context.socket(zmq.SUB)
  connect_string = 'tcp://{}:{}'.format(
      zmq_write_host, write_port)
  write_sock.connect(connect_string)
  write_sock.setsockopt(zmq.SUBSCRIBE, b"")
  return write_sock

while True:
    message = socket.recv()
    print("Received request: %s" % message)
    socket.send(b"World")

def read(sock):
  while True:
    print('waiting for read requests...')
    data =sock.recv_json()
    raw = data.get('raw', 'sample read data')
    print(raw)
    time.sleep(3)
    sock.send(b'Query result: Some sample result data')

def write(sock):
  while True:
    print('waiting for write requests...')
    data = sock.recv_json()
    raw = data.get('raw', 'sample write data')
    print('Going to write the following to the db node: %s' % raw)
    time.sleep(3)

def main(uname):
  # ZeroMQ Context
  context = zmq.Context()
  read_sock = bind_chat_port(context)
  write_sock = bind_display_port(context)

  write_thread = threading.Thread(target=write, args=(write_sock))
  write_thread.daemon = True
  write_thread.start()

  read_thread = threading.Thread(target=read, args=(read_sock))
  read_thread.daemon = True
  read_thread.start()

  read_thread.join()
  write_thread.join()

if __name__ == '__main__':
  main()
