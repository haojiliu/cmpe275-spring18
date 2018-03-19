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
  return 'Hello World'

@app.route('/register/<node_type>', methods=['GET'])
def register(node_type):
  print('yessss a node trying to register!!!!')
  # TODO: register the node
  new_node = Node.create(constants.node_type_string_to_constant[node_type])
  return new_node.id

@app.route('/ping/<node_id>', methods=['GET'])
def ping(node_id):
  print('yessss a node trying to ping!!!!')
  Node.touch(node_id)

if __name__ == '__main__':
  app.run(host='0.0.0.0', debug=True)
