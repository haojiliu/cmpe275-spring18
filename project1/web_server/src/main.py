#!/usr/bin/env python
# Haoji liu
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

# Homepage
@app.route('/')
def index():
  return 'Hello World'

@app.route('/data/v1', methods=['GET','POST'])
def api_data_v1():
  if request.method == 'POST':
    post_data = dict(request.form)
    return render_template('data_viewer.html')
  else:
    return render_template('data_viewer.html')

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
  app.run(host='0.0.0.0', debug=True, port=8080)
