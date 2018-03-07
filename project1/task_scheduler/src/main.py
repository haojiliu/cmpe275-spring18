#!/usr/bin/env python
# Haoji liu
import json
import time
import logging
# Third party module
import requests

import zmq
_log = logging.getLogger(__name__)


registered_db_nodes = []

zmq_read_host = 'cmpe275_task_scheduler'
read_client_port = 5559
read_worker_port = 5560

# TODO: initialize a binding proxy here between web and db nodes for queries
#
# while True:
#     time.sleep(5)
#     _log.info('trying to get a read request and distribute to one db node...')

def main():
    """ main method """

    context = zmq.Context()

    # Socket facing clients
    frontend = context.socket(zmq.ROUTER)
    connect_string = 'tcp://{}:{}'.format(zmq_read_host, read_client_port)
    frontend.bind(connect_string)
    # Socket facing services
    backend  = context.socket(zmq.DEALER)
    connect_string = 'tcp://{}:{}'.format(zmq_read_host, read_worker_port)
    backend.bind(connect_string)

    # TODO: again, if this is too high level, we can replace it with our own homebrew proxy module
    zmq.proxy(frontend, backend)

    # We never get here…
    frontend.close()
    backend.close()
    context.term()

if __name__ == "__main__":
    main()
