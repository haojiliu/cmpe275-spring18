import re
import socket

def try_get_ip(my_ip):
  """Get IP if it's hostname like `cmpe275` or `www.google.com`"""
  if is_ip_addr(my_ip):
    return my_ip
  else:
    return socket.gethostbyname(my_ip)

def is_ip_addr(my_ip):
  return re.match(r"^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$",my_ip) is not None
