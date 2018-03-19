from datetime import datetime

# sqlite connection
import sqlite3

import constants

def report(job):
  # report error on a given node
  return True

def check_health(node_dict):
  # TODO: move this to be one conn per uwsgi worker???
  conn = sqlite3.connect('/srv/tmp.db')
  # 1. write a job entry to local sqlite
  c = conn.cursor()

  for job in c.execute('select * from etl_jobs;'):
    last_updated_time = datetime.strptime(job.updated_at, '%b %d %Y %I:%M%p')
    if datetime.now() - last_updated_time > MIN_HEARTBEAT_INTERVAL * 2:
      # TODO: use sqlalchemy
      report(job)
      job.flags = constants.CONST_NODE_FLAG_DEAD
      conn.add(job)

  conn.commit()
  conn.close()
  return True
