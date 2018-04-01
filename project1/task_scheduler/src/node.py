# sqlite connection
import sqlite3
import uuid
from datetime import datetime

import sqlite3

import constants

# TODO: use sqlalchemy
class Node:
  def __init__(self, my_ip):
    self.id = uuid.uuid4()
    self.my_ip = my_ip
    # TODO: timezone adjustment
    self.created_at_utc = str(datetime.now())
    self.updated_at_utc = str(datetime.now())
    self.flags = 0

  def query_by_ip(node_ip):
    return None

  def touch(node_ip):
    # TODO: for now we just update the timestamp for each ping
    current_timestamp = str(datetime.now())
    conn = sqlite3.connect(constants.DB_FILE_PATH)
    c = conn.cursor()
    c.execute('update nodes set updated_at_utc = %s where node_ip == %s' % (current_timestamp, node_ip))
    conn.commit()
    conn.close()
    return True

  def create(node_type):
    new_node = Node(node_up)
    # TODO: move this to be one conn per uwsgi worker???
    conn = sqlite3.connect(constants.DB_FILE_PATH)
    # 1. write a job entry to local sqlite
    c = conn.cursor()
    _log.info('going to write the new node')
    c.execute('insert into nodes values ()')
    conn.commit()
    conn.close()
    return True
