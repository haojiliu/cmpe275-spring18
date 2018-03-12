import zmq
zmq_read_host = '172.18.0.2'
zmq_read_host = 'cmpe275_task_scheduler'
#zmq_read_host = '*'
read_client_port = 5559

zmq_context = zmq.Context()
read_client_sock = zmq_context.socket(zmq.REQ)
connect_string = 'tcp://{}:{}'.format(
    zmq_read_host, read_client_port)
print(connect_string)
read_client_sock.bind(connect_string)
print('success!')
