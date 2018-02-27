import grpc
import monitor_slave_pb2
import monitor_slave_pb2_grpc

class MonitorSlaveServer(data_pb2_grpc.MonitorSlaveServicer):
    def ping(self, request, context):
        print(request.data)
        return monitor_slave_pb2.Response(data='pong')

    def switchMode(self, request, context):
        # Here is the main logic on handling mode switching for fail over
        print(request.data)
        return monitor_slave_pb2.Response(data='pong')
