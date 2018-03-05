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

    def replicate(self, request, context):
        # This is the main logic for replica node to call to retrieve the oplog
        # The role of the current node can be retrieved by linux env var DB_ROLE
        pass
