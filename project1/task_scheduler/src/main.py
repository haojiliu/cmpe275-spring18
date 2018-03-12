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

zmq_read_host = '*'
#zmq_read_host = '172.18.0.2'
read_client_port = 5559
read_worker_port = 5560

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
