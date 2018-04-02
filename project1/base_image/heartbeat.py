# Haoji Liu
# This runs before each node is booted up to register the node to task scheduler
# retrurns True if successfully registered, False otherwise
import requests, time, sys
import socket
import fcntl
import struct

CONST_TASK_SCHEDULER_HOST = 'cmpe275_task_scheduler'
CONST_RETRY_SLEEP_INTERVAL = 5 # in seconds
CONST_RETRY_CNT = 5 # retry 5 times at most

def get_ip_address(ifname):
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    return socket.inet_ntoa(fcntl.ioctl(
        s.fileno(),
        0x8915,  # SIOCGIFADDR
        struct.pack('256s', ifname[:15])
    )[20:24])

def try_register(my_ip):
  url = CONST_TASK_SCHEDULER_HOST + '/register/' + my_ip
  r = requests.get(url)
  return r.status_code == 200

def ping(my_ip):
  url = CONST_TASK_SCHEDULER_HOST + '/ping/' + my_ip
  r = requests.get(url)
  return r.status_code == 200

is_registered = False
retry_cnt = 0

my_ip = get_ip_address('eth0').replace('.', '-')  # '192.168.0.110'

while not is_registered and retry_cnt < CONST_RETRY_CNT:
  res = try_register(my_ip)
  if res is True:
    is_registered = True
  time.sleep(CONST_RETRY_SLEEP_INTERVAL)
  retry_cnt = retry_cnt + 1

if retry_cnt >= CONST_RETRY_CNT:
  # TODO: send error
  pass

while True:
  time.sleep(5)
  ping(my_ip)
