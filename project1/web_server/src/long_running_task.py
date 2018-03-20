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

# TODO: move off global vars

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
    "station": 'test station',
    "timestamp_utc": "2018-03-18 12:00:00",
    "raw": "12.3, 32.2, sw, 411.2, 2341",
    "created_at_utc": "2018-03-19 12:00:00"
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
      _log.info('going to process one job from table')
      _log.info(str(job))
      print(str(job))

      for entry in process_job(job):
        _log.info('going to publish the data to all db nodes...')
        write_sock.send_json(entry)

      # update status
      query_str = 'update etl_jobs set status = %d where job_id == %d;' % (constants.CONST_STATUS_DONE, job[0])
      print(query_str)
      c.execute(query_str)
      conn.commit()
    print('going to sleep for a while....')
    _log.info('going to sleep for a while....')
    time.sleep(5)

if __name__ == '__main__':
  try:
    conn = get_db_conn()
    main(conn)
  except:
    raise
  finally:
    conn.close()
