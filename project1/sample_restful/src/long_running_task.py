"""This file acts as a cron job where the clients upload data files to this server,
reads by this job, chunkify to small data chunks, and send over to write to all the slave database nodes"""
import time, logging
import zmq
# sqlite connection
import sqlite3

import constants

_log = logging.getLogger(__name__)

def get_db_conn():
  """ create a database connection to the SQLite database
      specified by the db_file
  :param db_file: database file
  :return: Connection object or None
  """
  try:
    conn = sqlite3.connect(constants.DB_FILE_PATH)
    return conn
  except Error as e:
    print(e)

# to publish write requests to all
zmq_context = zmq.Context()
write_sock = zmq_context.socket(zmq.PUB)
connect_string = 'tcp://{}:{}'.format(
    constants.zmq_write_host, constants.write_port)
write_sock.bind(connect_string)

def chunkify(rows):
  """In case one file contains too much data"""
  yield data

def process_job(job):
  return {
    "station": 'some sample weather data'
  }
  fpath = None
  job_dict = {}
  with open(fpath) as f:
    for line in f:
      yield line

def main(conn):
  c = conn.cursor()
  query_str = 'select * from etl_jobs where status == %d;' % constants.CONST_STATUS_NEW
  while True:
    # TODO: move to sqlalchemy
    for job in c.execute(query_str):
      for entry in process_job(job):
        write_sock.send_json(entry)

      # update status
      query_str = 'update etl_jobs set status = %d where job_id == %d;' % (constants.CONST_STATUS_DONE, job[0])
      c.execute(query_str)
      conn.commit()
    time.sleep(5)

if __name__ == '__main__':
  try:
    conn = get_db_conn()
    main(conn)
  except:
    raise
  finally:
    conn.close()
