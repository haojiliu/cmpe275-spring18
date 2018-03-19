#!/usr/bin/env python
# Haoji liu
from datetime import datetime
import json
import os, logging, sys
# Third party module
import requests
from flask import Flask, render_template, request, redirect, url_for
from werkzeug.utils import secure_filename

from flask import send_from_directory

UPLOAD_FOLDER = '/tmp/'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])

# create a Flask app
app = Flask("cmpe275")
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 32 * 1024 * 1024 # max file size 32MB

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
import sqlite3

import constants

# TODO: one context per uwsgi worker????
zmq_context = zmq.Context()
connect_string = 'tcp://{}:{}'.format(
    constants.zmq_read_host, constants.read_client_port)

from constants import LOG_FILENAME, LOG_BASE_DIR
def bootstrap():
  """
  Returns: bool - True if bootstrap finished without error, False otherwise
  """
  filename = os.path.join(LOG_BASE_DIR, LOG_FILENAME)
  logging.basicConfig(
        filename=filename,
        filemode='a+',
        level=logging.INFO,
        format='%(asctime)s %(message)s')

  return True


def read(sock, params):
  # TODO: add more params like table name, target station
  sock.send_json(params)
  # wait for response
  _log.info('sent the request and waiting in read()...')
  resp = sock.recv_json()
  _log.info('got the response and quitting read()')
  return resp

def write(post_dict):
  # TODO: move this to be one conn per uwsgi worker???
  conn = sqlite3.connect('/srv/tmp.db')
  # 1. write a job entry to local sqlite
  c = conn.cursor()

  _log.info('going to write an entry to etl_jobs table')

  current_timestamp = str(datetime.now())
  # Larger example that inserts many records at a time
  entries = [(post_dict['client_ip'], post_dict['file_path'], 0, constants.CONST_STATUS_NEW, current_timestamp),]
  c.executemany('INSERT INTO etl_jobs (client_ip,file_path,flags,status,created_at) VALUES (?, ?, ?, ?, ?)', entries)
  _log.info('done with writing one entry to etl_jobs')
  conn.commit()
  conn.close()
  return True

######################################
def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

def get_read_socket():
  # Open a new socket per request
  read_client_sock = zmq_context.socket(zmq.REQ)
  read_client_sock.setsockopt(zmq.LINGER, 100)
  # 10 sec read timeout
  read_client_sock.setsockopt(zmq.RCVTIMEO, 1000)

  _log.info('read socket connecting to %s' % connect_string)
  read_client_sock.connect(connect_string)
  _log.info('read socket connected to %s' % connect_string)
  return read_client_sock

# Homepage
@app.route('/')
def index():
  return 'Hello World'

@app.route('/data/read/v1/<from_utc>/<to_utc>', methods=['GET','POST'])
def api_read_v1(from_utc, to_utc):
  _log.info('yes its a read request...')
  if request.method == 'POST':
    return 'POST method not supported'
  else:
    # Read request
    resp = 'read response placeholder'
    try:
      read_client_sock = get_read_socket()
      params = {
        'from_utc': from_utc,
        'to_utc': to_utc
      }
      resp = read(read_client_sock, params)
    except Exception as e:
      _log.info(e)
    finally:
      # Make sure it's closed
      _log.info('closing the read socket...')
      read_client_sock.disconnect(connect_string)
      read_client_sock.close()

    return str(resp)

@app.route('/uploads/<filename>')
def uploaded_file(filename):
  return send_from_directory(app.config['UPLOAD_FOLDER'], filename)

@app.route('/data/upload/v1', methods=['GET','POST'])
def api_write_v1():
  if request.method == 'POST':
    # check if the post request has the file part
    if 'file' not in request.files:
      _log.info('No file part')
      return redirect(request.url)
    file = request.files['file']
    # if user does not select file, browser also
    # submit a empty part without filename
    if file.filename == '':
      _log.info('No selected file')
      return redirect(request.url)
    if file and allowed_file(file.filename):
      _log.info('file name allowed!')
      filename = secure_filename(file.filename)
      fpath = os.path.join(app.config['UPLOAD_FOLDER'], filename)
      file.save(fpath)
      post_data = {
        'client_ip': request.remote_addr,
        'file_path': fpath
      }
      _log.info(post_data)
      write(post_data)
      return redirect(url_for('uploaded_file',
                              filename=filename))
  return '''
  <!doctype html>
  <title>Upload new File</title>
  <h1>Upload new File</h1>
  <form method=post enctype=multipart/form-data>
    <p><input type=file name=file>
       <input type=submit value=Upload>
  </form>
  '''

if __name__ == '__main__':
  bootstrap()
  app.run(host='0.0.0.0', debug=True)
