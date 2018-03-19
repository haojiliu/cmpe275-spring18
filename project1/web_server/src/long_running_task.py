import time, logging
import zmq

_log = logging.getLogger(__name__)

zmq_write_host = '0.0.0.0'
write_port = 8081

CONST_STATUS_NEW = 1 << 0
CONST_STATUS_RUNNING = 1 << 1
CONST_STATUS_DONE = 1 << 2
CONST_STATUS_ERROR = 1 << 3

# to publish write requests to all
zmq_context = zmq.Context()
write_sock = zmq_context.socket(zmq.PUB)
connect_string = 'tcp://{}:{}'.format(
    zmq_write_host, write_port)
write_sock.bind(connect_string)

# sqlite connection
import sqlite3
conn = sqlite3.connect('/srv/tmp.db')
c = conn.cursor()

def chunkify(data):
  """In case one file contains too much data"""
  yield data

while True:
  for job in c.execute('select * from etl_jobs where status == %d;' % CONST_STATUS_NEW):
    _log.info('going to process one job from table')
    _log.info(str(job))
    print(str(job))

    entry =
    {
      "station": 'test station',
      "timestamp_utc": "2018-03-18 12:00:00",
      "raw": "12.3, 32.2, sw, 411.2, 2341",
      "created_at_utc": "2018-03-19 12:00:00"
    }
    write_sock.send_json(entry)
    # update status
    c.execute('update etl_jobs set status = %d where id = %d', (CONST_STATUS_DONE, job(0)))
    conn.commit()

  time.sleep(60)
