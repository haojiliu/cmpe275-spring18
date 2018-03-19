import time, logging
import zmq

# sqlite connection
import sqlite3

_log = logging.getLogger(__name__)

zmq_write_host = '0.0.0.0'
write_port = 8081

CONST_STATUS_NEW = 1 << 0
CONST_STATUS_RUNNING = 1 << 1
CONST_STATUS_DONE = 1 << 2
CONST_STATUS_ERROR = 1 << 3

DB_FILE_PATH = '/srv/tmp.db'

def get_db_conn():
  """ create a database connection to the SQLite database
      specified by the db_file
  :param db_file: database file
  :return: Connection object or None
  """
  try:
    conn = sqlite3.connect(DB_FILE_PATH)
    return conn
  except Error as e:
    print(e)

# TODO: move off global vars

# to publish write requests to all
zmq_context = zmq.Context()
write_sock = zmq_context.socket(zmq.PUB)
connect_string = 'tcp://{}:{}'.format(
    zmq_write_host, write_port)
write_sock.bind(connect_string)

def chunkify(data):
  """In case one file contains too much data"""
  yield data

def main(conn):
  c = conn.cursor()
  while True:
    for job in c.execute('select * from etl_jobs where status == %d;' % CONST_STATUS_NEW):
      _log.info('going to process one job from table')
      _log.info(str(job))
      print(str(job))

      entry = {
        "station": 'test station',
        "timestamp_utc": "2018-03-18 12:00:00",
        "raw": "12.3, 32.2, sw, 411.2, 2341",
        "created_at_utc": "2018-03-19 12:00:00"
      }
      _log.info('going to publush the data to all db nodes...')

      write_sock.send_json(entry)

      # update status
      query_str = 'update etl_jobs set status = %d where job_id == %d;' % (CONST_STATUS_DONE, job[0])
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
