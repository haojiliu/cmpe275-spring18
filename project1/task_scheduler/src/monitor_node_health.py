from datetime import datetime

# sqlite connection
import sqlite3

import constants

def report(job):
  # report error on a given node
  print('going to report the node!!!')
  return True

def check_health():
  conn = sqlite3.connect('/srv/tmp.db')
  print(conn)
  c = conn.cursor()

  for job in c.execute('select * from nodes;'):
    last_updated_time = datetime.strptime(job.updated_at, '%b %d %Y %I:%M%p')
    if datetime.now() - last_updated_time > constants.MIN_HEARTBEAT_INTERVAL * 2:
      print('find a bad node! %s' % str(job))
      # TODO: use sqlalchemy
      report(job)
      job.flags = constants.CONST_NODE_FLAG_DEAD
      conn.add(job)

  conn.commit()
  conn.close()
  return True

if __name__ == '__main__':
  check_health()
