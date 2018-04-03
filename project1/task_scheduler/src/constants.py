# Node status
CONST_NODE_FLAG_ACTIVE = 0
CONST_NODE_FLAG_DEAD = 10


# TODO: move this to a docker env variable for orchestration
MIN_HEARTBEAT_INTERVAL = 5 # in seconds

zmq_read_host = '0.0.0.0'
#zmq_read_host = '172.18.0.2'
read_client_port = 5559
read_worker_port = 5560

DB_FILE_PATH = '/srv/tmp.db'
