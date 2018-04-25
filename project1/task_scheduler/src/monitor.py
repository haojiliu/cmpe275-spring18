#!/usr/bin/env python
# Haoji liu
import logging

from flask import Flask
from node import Node
import constants

# create a Flask app
app = Flask('haoji')

# Homepage
@app.route('/')
def index():
  return 'This is task scheduler'

@app.route('/register/<node_ip>', methods=['GET'])
def register(node_ip):
  #logging.warning('yessss a node trying to register!!!!')
  if Node.create(node_ip):
    return 'success'

@app.route('/ping/<node_ip>', methods=['GET'])
def ping(node_ip):
  #logging.warning('yessss a node trying to ping!!!!')
  if Node.touch(node_ip):
    return 'success'

@app.route('/all', methods=['GET'])
def get_all():
  return Node.get_all()

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=80, debug=True)
