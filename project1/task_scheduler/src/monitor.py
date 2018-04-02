#!/usr/bin/env python
# Haoji liu
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
  print('yessss a node trying to register!!!!')
  # TODO: register the node
  new_node = Node.create(node_ip)
  return new_node.id

@app.route('/ping/<node_ip>', methods=['GET'])
def ping(node_ip):
  print('yessss a node trying to ping!!!!')
  Node.touch(node_ip)

if __name__ == '__main__':
  app.run(host='0.0.0.0', port=80, debug=True)
