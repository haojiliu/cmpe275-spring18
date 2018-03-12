#!/usr/bin/env python
# Haoji liu
from datetime import datetime
import json
import logging, sys
# Third party module
import requests
from flask import Flask, render_template, request

_log = logging.getLogger(__name__)

_log.setLevel(logging.DEBUG)

######################################
# TODO: move all the crap below to another file
ch = logging.StreamHandler(sys.stdout)
ch.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
_log.addHandler(ch)

# create a Flask app
app = Flask('haoji')


import zmq
zmq_read_host = '172.18.0.3'
read_client_port = 5559
# sqlite connection
import sqlite3

CONST_STATUS_NEW = 1 << 0
CONST_STATUS_RUNNING = 1 << 1
CONST_STATUS_DONE = 1 << 2
CONST_STATUS_ERROR = 1 << 3

# TODO: one context per uwsgi worker????
zmq_context = zmq.Context()
connect_string = 'tcp://{}:{}'.format(
    zmq_read_host, read_client_port)

def read(sock):
  message = 'read request from web server'
  data = {'raw': message}
  sock.send_json(data)
  # wait for response
  _log.info('sent the request and waiting in read()...')
  resp = sock.recv()
  _log.info('got the response and quitting read()')
  return resp

def write(post_data):
  # TODO: move this to be one conn per uwsgi worker???
  conn = sqlite3.connect('/srv/tmp.db')
  # 1. write a job entry to local sqlite
  c = conn.cursor()

  _log.info('going to write an entry to etl_jobs table')

  current_timestamp = str(datetime.now())
  # Larger example that inserts many records at a time
  entries = [('12,4,2,1', '/tmp/348dhvsq.gz', 0, CONST_STATUS_NEW, current_timestamp),]
  c.executemany('INSERT INTO etl_jobs (client_ip,file_path,flags,status,created_at) VALUES (?, ?, ?, ?, ?)', entries)
  _log.info('done with writing one entry to etl_jobs')
  conn.commit()
  conn.close()
  return True

######################################

# Homepage
@app.route('/')
def index():
  return 'Hello World'

@app.route('/data/read/v1', methods=['GET','POST'])
def api_read_v1():
  if request.method == 'POST':
    return 'POST method not supported'
  else:
    # Read request
    _log.info('yessss a read request received!!!!')
    resp = 'read response placeholder'
    try:
      # Open a new socket per request
      read_client_sock = zmq_context.socket(zmq.REQ)
      _log.info('read socket connecting to %s' % connect_string)
      read_client_sock.connect(connect_string)
      _log.info('read socket connected to %s' % connect_string)
      resp = read(read_client_sock)
    finally:
      # Make sure it's closed
      read_client_sock.disconnect(connect_string)
      read_client_sock.close()

    return str(resp)

@app.route('/data/write/v1', methods=['GET','POST'])
def api_write_v1():
  if request.method == 'POST':
    return 'POST method not supported'
  else:
    # Write request
    _log.info('noooo a write request received!!!!')
    post_data = dict(request.form)
    write(post_data)
    return 'write request processed, data will be available in 5-15min'


if __name__ == '__main__':
  app.run(host='0.0.0.0', debug=True)
