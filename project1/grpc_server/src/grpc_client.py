# Haoji Liu
# This is the grpc client, that will read a data file, chunk it into several messages, and send it to grpc server
# Haoji Liu
import grpc
import data_pb2_grpc
from data_pb2 import Request, Response, PingRequest, PutRequest, GetRequest, DatFragment, MetaData, QueryParams


class Client():
  def __init__(self, host='0.0.0.0', port=3000):
    self.channel = grpc.insecure_channel('%s:%d' % (host, port))
    self.stub = data_pb2_grpc.CommunicationServiceStub(self.channel)

  def ping(self, data):
    req = Request(
      fromSender='some ping sender',
      toReceiver='some ping receiver',
      ping=PingRequest(msg='this is a sample ping request'))
    resp = self.stub.MessageHandler(req)
    return resp.msg

  def put(self, fpath):
    req = Request(
      fromSender='some put sender',
      toReceiver='some put receiver',
      putRequest=PutRequest(
          metaData=MetaData(uuid='14829'),
          datFragment=DatFragment(data=b'sample raw bytes'))
      )
    resp = self.stub.MessageHandler(req)
    return resp.msg

  def get(self):
    req = Request(
      fromSender='some put sender',
      toReceiver='some put receiver',
      getRequest=GetRequest(
          metaData=MetaData(uuid='14829'),
          queryParams=QueryParams(from_utc='2017-01-01',to_utc='2017-01-02'))
      )
    resp = self.stub.MessageHandler(req)
    return resp.datFragment.data

def test():
  client = Client()
  print(client.ping('hello'))
  print(client.put('./20180101'))
  print(client.get())

if __name__ == '__main__':
  test()
