import time
# import grpc
# import monitor_slave_pb2
# import monitor_slave_pb2_grpc
#
# from concurrent import futures
#
# import monitor_slave_server
#
# def run(host, port):
#     server = grpc.server(futures.ThreadPoolExecutor(max_workers=1))
#     ds = monitor_slave_server.MonitorSlaveServer()
#     monitor_slave_pb2_grpc.add_MonitorSlaveServicer_to_server(ds, server)
#     server.add_insecure_port('%s:%d' % (host, port))
#     server.start()
#
#     _ONE_DAY_IN_SECONDS = 60 * 60 * 24
#     try:
#         print("Server started at...%d" % port)
#         while True:
#             time.sleep(_ONE_DAY_IN_SECONDS)
#     except KeyboardInterrupt:
#         server.stop(0)

while True:
    time.sleep(5)

# if __name__ == '__main__':
#     while True:
#         time.sleep(5)
#     # run('0.0.0.0', 3000)
