import grpc
import data_pb2
import data_pb2_grpc

class DataServer(data_pb2_grpc.DataServicer):
    def ping(self, request, context):
        print(request.data)
        return data_pb2.Response(data='pong')

    def query(self, request, context):
        # Here is the main logic on handling user queries,
        # connecting to database, and return the response in a protobuf format
        print(request.data)
        return data_pb2.QueryResponse(data='pong')
