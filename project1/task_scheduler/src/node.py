# sqlite connection
import uuid
from datetime import datetime
import logging

import sqlite3

import constants

# CREATE TABLE nodes (
#     [ip_addr] text PRIMARY KEY NOT NULL,
#     [flags] integer,
#     [created_at_utc] text,
#     [updated_at_utc] text)

# TODO: use sqlalchemy
class Node:
  def __init__(self, my_ip):
    self.ip_addr = my_ip
    self.flags = 0
    # TODO: timezone adjustment
    self.created_at_utc = str(datetime.now())
    self.updated_at_utc = str(datetime.now())

  def query_by_ip(node_ip):
    return None

  def touch(node_ip):
    # TODO: for now we just update the timestamp for each ping
    logging.warning('touching node: %s' % node_ip)
    current_timestamp = str(datetime.now())
    conn = sqlite3.connect(constants.DB_FILE_PATH)
    c = conn.cursor()
    q = "update nodes set updated_at_utc = '%s' where ip_addr == %s" % (current_timestamp, node_ip)
    logging.warning('running query: %s' % q)
    c.execute(q)
    conn.commit()
    conn.close()
    return True

  def get_all():
    conn = sqlite3.connect(constants.DB_FILE_PATH)
    c = conn.cursor()
    res = c.execute('select * from nodes')
    conn.close()
    return res

  def create(my_ip):
    new_node = Node(my_ip)
    # TODO: move this to be one conn per uwsgi worker???
    conn = sqlite3.connect(constants.DB_FILE_PATH)
    # 1. write a job entry to local sqlite
    c = conn.cursor()
    logging.warning('going to create the new node in db')
    # Larger example that inserts many records at a time
    entries = [(new_node.ip_addr, new_node.flags, new_node.created_at_utc, new_node.updated_at_utc),]
    c.executemany('INSERT OR IGNORE INTO nodes (ip_addr,flags,created_at_utc,updated_at_utc) VALUES (?, ?, ?, ?)', entries)
    conn.commit()
    conn.close()
    logging.warning('successfully write the new node')

    return True
