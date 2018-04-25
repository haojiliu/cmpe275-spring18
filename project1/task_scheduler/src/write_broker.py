#!/usr/bin/env python
# Haoji liu
import logging

import zmq

import constants
_log = logging.getLogger(__name__)

def main():
    """ main method """

    context = zmq.Context()

    # Socket facing clients
    frontend = context.socket(zmq.XSUB)
    connect_string = 'tcp://{}:{}'.format(constants.zmq_write_host, constants.write_pub_port)
    frontend.bind(connect_string)
    # Socket facing services
    backend  = context.socket(zmq.XPUB)
    connect_string = 'tcp://{}:{}'.format(constants.zmq_write_host, constants.write_sub_port)
    backend.bind(connect_string)

    # TODO: again, if this is too high level, we can replace it with our own homebrew proxy module
    zmq.proxy(frontend, backend)

    # Code shouldn't reach here
    frontend.close()
    backend.close()
    context.term()

if __name__ == "__main__":
    main()
