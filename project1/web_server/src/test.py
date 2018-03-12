# Haoji Liu

# This is for testing only, no production use
import zmq
zmq_read_host = '172.18.0.3'
#zmq_read_host = 'cmpe275_task_scheduler'
#zmq_read_host = '*'
read_client_port = 5559

connect_string = 'tcp://{}:{}'.format(
    zmq_read_host, read_client_port)

try:
  zmq_context = zmq.Context()
  read_client_sock = zmq_context.socket(zmq.REQ)
  print(connect_string)
  read_client_sock.connect(connect_string)
  print('success!')
  message = 'read request from web server'
  data = {'raw': message}
  read_client_sock.send_json(data)
  # wait for response
  print('sent the request and waiting in read()...')
  resp = read_client_sock.recv()
  print('got the response and quitting read()')
  print(str(resp))
except Exception as e:
  print(e)
finally:
  print('going to disconnect')
  read_client_sock.disconnect(connect_string)
