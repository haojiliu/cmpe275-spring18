#!/usr/bin/env python
# Haoji liu
import json
import time
import logging
# Third party module
import requests


registered_db_nodes = []
registered_ftp_nodes = []

# TODO: not sure if should use grpc here or python with postgres to store registered nodes info

while True:
    time.sleep(5)
    # main logic will be somewhat like This
    # 1. sleep for a certain amount
    # 2. ping all registered devices to see if they are still alive
    # 3. if not, send grpc calls to monitor client to switch the first replica node to the leader
