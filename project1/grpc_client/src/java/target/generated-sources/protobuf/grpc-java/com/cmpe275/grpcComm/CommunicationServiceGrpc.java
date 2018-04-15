package com.cmpe275.grpcComm;

import static io.grpc.stub.ClientCalls.asyncUnaryCall;
import static io.grpc.stub.ClientCalls.asyncServerStreamingCall;
import static io.grpc.stub.ClientCalls.asyncClientStreamingCall;
import static io.grpc.stub.ClientCalls.asyncBidiStreamingCall;
import static io.grpc.stub.ClientCalls.blockingUnaryCall;
import static io.grpc.stub.ClientCalls.blockingServerStreamingCall;
import static io.grpc.stub.ClientCalls.futureUnaryCall;
import static io.grpc.MethodDescriptor.generateFullMethodName;
import static io.grpc.stub.ServerCalls.asyncUnaryCall;
import static io.grpc.stub.ServerCalls.asyncServerStreamingCall;
import static io.grpc.stub.ServerCalls.asyncClientStreamingCall;
import static io.grpc.stub.ServerCalls.asyncBidiStreamingCall;

@javax.annotation.Generated("by gRPC proto compiler")
public class CommunicationServiceGrpc {

  private CommunicationServiceGrpc() {}

  public static final String SERVICE_NAME = "grpcComm.CommunicationService";

  // Static method descriptors that strictly reflect the proto.
  @io.grpc.ExperimentalApi
  public static final io.grpc.MethodDescriptor<com.cmpe275.grpcComm.Request,
      com.cmpe275.grpcComm.Response> METHOD_PUT_HANDLER =
      io.grpc.MethodDescriptor.create(
          io.grpc.MethodDescriptor.MethodType.CLIENT_STREAMING,
          generateFullMethodName(
              "grpcComm.CommunicationService", "putHandler"),
          io.grpc.protobuf.ProtoUtils.marshaller(com.cmpe275.grpcComm.Request.getDefaultInstance()),
          io.grpc.protobuf.ProtoUtils.marshaller(com.cmpe275.grpcComm.Response.getDefaultInstance()));
  @io.grpc.ExperimentalApi
  public static final io.grpc.MethodDescriptor<com.cmpe275.grpcComm.Request,
      com.cmpe275.grpcComm.Response> METHOD_GET_HANDLER =
      io.grpc.MethodDescriptor.create(
          io.grpc.MethodDescriptor.MethodType.SERVER_STREAMING,
          generateFullMethodName(
              "grpcComm.CommunicationService", "getHandler"),
          io.grpc.protobuf.ProtoUtils.marshaller(com.cmpe275.grpcComm.Request.getDefaultInstance()),
          io.grpc.protobuf.ProtoUtils.marshaller(com.cmpe275.grpcComm.Response.getDefaultInstance()));
  @io.grpc.ExperimentalApi
  public static final io.grpc.MethodDescriptor<com.cmpe275.grpcComm.Request,
      com.cmpe275.grpcComm.Response> METHOD_PING =
      io.grpc.MethodDescriptor.create(
          io.grpc.MethodDescriptor.MethodType.UNARY,
          generateFullMethodName(
              "grpcComm.CommunicationService", "ping"),
          io.grpc.protobuf.ProtoUtils.marshaller(com.cmpe275.grpcComm.Request.getDefaultInstance()),
          io.grpc.protobuf.ProtoUtils.marshaller(com.cmpe275.grpcComm.Response.getDefaultInstance()));

  public static CommunicationServiceStub newStub(io.grpc.Channel channel) {
    return new CommunicationServiceStub(channel);
  }

  public static CommunicationServiceBlockingStub newBlockingStub(
      io.grpc.Channel channel) {
    return new CommunicationServiceBlockingStub(channel);
  }

  public static CommunicationServiceFutureStub newFutureStub(
      io.grpc.Channel channel) {
    return new CommunicationServiceFutureStub(channel);
  }

  public static interface CommunicationService {

    public io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Request> putHandler(
        io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Response> responseObserver);

    public void getHandler(com.cmpe275.grpcComm.Request request,
        io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Response> responseObserver);

    public void ping(com.cmpe275.grpcComm.Request request,
        io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Response> responseObserver);
  }

  public static interface CommunicationServiceBlockingClient {

    public java.util.Iterator<com.cmpe275.grpcComm.Response> getHandler(
        com.cmpe275.grpcComm.Request request);

    public com.cmpe275.grpcComm.Response ping(com.cmpe275.grpcComm.Request request);
  }

  public static interface CommunicationServiceFutureClient {

    public com.google.common.util.concurrent.ListenableFuture<com.cmpe275.grpcComm.Response> ping(
        com.cmpe275.grpcComm.Request request);
  }

  public static class CommunicationServiceStub extends io.grpc.stub.AbstractStub<CommunicationServiceStub>
      implements CommunicationService {
    private CommunicationServiceStub(io.grpc.Channel channel) {
      super(channel);
    }

    private CommunicationServiceStub(io.grpc.Channel channel,
        io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected CommunicationServiceStub build(io.grpc.Channel channel,
        io.grpc.CallOptions callOptions) {
      return new CommunicationServiceStub(channel, callOptions);
    }

    @java.lang.Override
    public io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Request> putHandler(
        io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Response> responseObserver) {
      return asyncClientStreamingCall(
          getChannel().newCall(METHOD_PUT_HANDLER, getCallOptions()), responseObserver);
    }

    @java.lang.Override
    public void getHandler(com.cmpe275.grpcComm.Request request,
        io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Response> responseObserver) {
      asyncServerStreamingCall(
          getChannel().newCall(METHOD_GET_HANDLER, getCallOptions()), request, responseObserver);
    }

    @java.lang.Override
    public void ping(com.cmpe275.grpcComm.Request request,
        io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Response> responseObserver) {
      asyncUnaryCall(
          getChannel().newCall(METHOD_PING, getCallOptions()), request, responseObserver);
    }
  }

  public static class CommunicationServiceBlockingStub extends io.grpc.stub.AbstractStub<CommunicationServiceBlockingStub>
      implements CommunicationServiceBlockingClient {
    private CommunicationServiceBlockingStub(io.grpc.Channel channel) {
      super(channel);
    }

    private CommunicationServiceBlockingStub(io.grpc.Channel channel,
        io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected CommunicationServiceBlockingStub build(io.grpc.Channel channel,
        io.grpc.CallOptions callOptions) {
      return new CommunicationServiceBlockingStub(channel, callOptions);
    }

    @java.lang.Override
    public java.util.Iterator<com.cmpe275.grpcComm.Response> getHandler(
        com.cmpe275.grpcComm.Request request) {
      return blockingServerStreamingCall(
          getChannel().newCall(METHOD_GET_HANDLER, getCallOptions()), request);
    }

    @java.lang.Override
    public com.cmpe275.grpcComm.Response ping(com.cmpe275.grpcComm.Request request) {
      return blockingUnaryCall(
          getChannel().newCall(METHOD_PING, getCallOptions()), request);
    }
  }

  public static class CommunicationServiceFutureStub extends io.grpc.stub.AbstractStub<CommunicationServiceFutureStub>
      implements CommunicationServiceFutureClient {
    private CommunicationServiceFutureStub(io.grpc.Channel channel) {
      super(channel);
    }

    private CommunicationServiceFutureStub(io.grpc.Channel channel,
        io.grpc.CallOptions callOptions) {
      super(channel, callOptions);
    }

    @java.lang.Override
    protected CommunicationServiceFutureStub build(io.grpc.Channel channel,
        io.grpc.CallOptions callOptions) {
      return new CommunicationServiceFutureStub(channel, callOptions);
    }

    @java.lang.Override
    public com.google.common.util.concurrent.ListenableFuture<com.cmpe275.grpcComm.Response> ping(
        com.cmpe275.grpcComm.Request request) {
      return futureUnaryCall(
          getChannel().newCall(METHOD_PING, getCallOptions()), request);
    }
  }

  public static io.grpc.ServerServiceDefinition bindService(
      final CommunicationService serviceImpl) {
    return io.grpc.ServerServiceDefinition.builder(SERVICE_NAME)
      .addMethod(
        METHOD_PUT_HANDLER,
        asyncClientStreamingCall(
          new io.grpc.stub.ServerCalls.ClientStreamingMethod<
              com.cmpe275.grpcComm.Request,
              com.cmpe275.grpcComm.Response>() {
            @java.lang.Override
            public io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Request> invoke(
                io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Response> responseObserver) {
              return serviceImpl.putHandler(responseObserver);
            }
          }))
      .addMethod(
        METHOD_GET_HANDLER,
        asyncServerStreamingCall(
          new io.grpc.stub.ServerCalls.ServerStreamingMethod<
              com.cmpe275.grpcComm.Request,
              com.cmpe275.grpcComm.Response>() {
            @java.lang.Override
            public void invoke(
                com.cmpe275.grpcComm.Request request,
                io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Response> responseObserver) {
              serviceImpl.getHandler(request, responseObserver);
            }
          }))
      .addMethod(
        METHOD_PING,
        asyncUnaryCall(
          new io.grpc.stub.ServerCalls.UnaryMethod<
              com.cmpe275.grpcComm.Request,
              com.cmpe275.grpcComm.Response>() {
            @java.lang.Override
            public void invoke(
                com.cmpe275.grpcComm.Request request,
                io.grpc.stub.StreamObserver<com.cmpe275.grpcComm.Response> responseObserver) {
              serviceImpl.ping(request, responseObserver);
            }
          })).build();
  }
}
