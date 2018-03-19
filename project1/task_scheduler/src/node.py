# sqlite connection
import sqlite3
import uuid
from datetime import datetime

import sqlite3

# TODO: use sqlalchemy
class Node:
  def __init__(self, type):
    self.id = uuid.uuid4()
    self.type = type
    # TODO: timezone adjustment
    self.created_at_utc = str(datetime.now())
    self.updated_at_utc = str(datetime.now())
    self.flags = 0

  def query_by_id(node_id):
    return None

  def query_by_type(node_type):
    return None

  def touch(node_id):
    # TODO: for now we just update the timestamp for each ping
    return True

  def create(node_type):
    new_node = Node(node_type)
    # TODO: move this to be one conn per uwsgi worker???
    conn = sqlite3.connect('/srv/tmp.db')
    # 1. write a job entry to local sqlite
    c = conn.cursor()
    _log.info('going to write the new node')
    current_timestamp = str(datetime.now())
    conn.commit()
    conn.close()
    return True
