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

while True:
  for job in c.execute('select * from etl_jobs;'):
    _log.info('going to process on job from table')
    _log.info(str(job))
    print(str(job))
    # enqueue the job
    data = {
      'raw': 'a sample write task from web server'
    }
    write_sock.send_json(data)
  time.sleep(5)
