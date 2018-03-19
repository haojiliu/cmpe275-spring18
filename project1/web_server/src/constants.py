
CONST_STATUS_NEW = 1 << 0
CONST_STATUS_RUNNING = 1 << 1
CONST_STATUS_DONE = 1 << 2
CONST_STATUS_ERROR = 1 << 3

zmq_read_host = '172.18.0.3'
read_client_port = 5559
zmq_write_host = '0.0.0.0'
write_port = 8081

# the sqlite db file, not mongo
DB_FILE_PATH = '/srv/tmp.db'

# config python logging obj
LOG_FILENAME = 'application.log'
LOG_BASE_DIR = '/srv/logs'
