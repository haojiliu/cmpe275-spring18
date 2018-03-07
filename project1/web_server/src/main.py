#!/usr/bin/env python
# Haoji liu
from datetime import datetime
import json
import logging
# Third party module
import requests
from flask import Flask, render_template, request
# from pymongo import MongoClient
# from flask_pymongo import PyMongo

_log = logging.getLogger(__name__)

# create a Flask app
app = Flask('haoji')

# TODO: move all the crap below to another file

import zmq
zmq_read_host = 'cmpe275_task_scheduler'
zmq_write_host = 'cmpe275_web'
read_client_port = 5559
write_port = 8081

# sqlite connection
import sqlite3
conn = sqlite3.connect('/srv/tmp.db')

CONST_STATUS_NEW = 1 << 0
CONST_STATUS_RUNNING = 1 << 1
CONST_STATUS_DONE = 1 << 2
CONST_STATUS_ERROR = 1 << 3

def read(sock):
  # TODO: this should be talking to a proxy 2way binding on the task scheduler,
  # where the task scheduler will forward the request to one of the db nodes,
  # and send the response back when that corresponding db node finishes the query

  message = 'read request from web server'
  data = {'raw': message}
  read_sock.send_json(data)
  # wait for response
  resp = read_sock.recv_json()
  _log.info('got the response and quitting read()')
  return resp

def write(post_data):
  # 1. write a job entry to local sqlite
  c = conn.cursor()
  c.execute('select * from etl_jobs;')
  _log.info('going to write an entry to etl_jobs table')
  _log.info(str(c.fetchone()))

  current_timestamp = str(datetime.now())
  # Larger example that inserts many records at a time
  entries = [('12,4,2,1', '/tmp/348dhvsq.gz', 0, CONST_STATUS_NEW, current_timestamp),]
  c.executemany('INSERT INTO etl_jobs VALUES (client_ip,file_path,flags,status,created_at)', entries)
  _log.info('done with writing one entry to etl_jobs')

# Homepage
@app.route('/')
def index():
  return 'Hello World'

@app.route('/data/v1', methods=['GET','POST'])
def api_data_v1():
  if request.method == 'POST':
    # Write request
    _log.info('noooo a write request received!!!!')
    post_data = dict(request.form)
    write(post_data)
    return 'write request processed, data will be available in 5-15min'
  else:
    # Read request
    _log.info('yessss a read request received!!!!')
    # opens a new client to distinguish
    zmq_context = zmq.Context()
    read_client_sock = zmq_context.socket(zmq.REQ)
    connect_string = 'tcp://{}:{}'.format(
        zmq_read_host, read_client_port)
    read_client_sock.connect(connect_string)
    return str(read(read_client_sock))

# GET with variable
@app.route('/post/<int:post_id>')
def get_post(post_id):
  # show the post with the given id, the id is an integer
  return 'Post %d' % post_id


# create a MongoDB instance
# client = MongoClient(
# host='cmpe275_db',
# port=27017)
# db = client.mono
#users = db.users
#users.create_index("email", unique=True)

if __name__ == '__main__':
  app.run(host='0.0.0.0', debug=True, port=80)
