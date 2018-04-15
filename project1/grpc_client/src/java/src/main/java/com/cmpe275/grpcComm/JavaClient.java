
package com.cmpe275.grpcComm;

import java.io.BufferedWriter;
import java.util.Iterator;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.google.protobuf.ByteString;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import io.grpc.StatusRuntimeException;

public class JavaClient {
    //const
    final static int CONST_MEDIA_TYPE_TEXT = 1;

    final static int CONST_CHUNK_SIZE = 10;

    final static String CONST_MESOWEST_HEADER = "STN YYMMDD/HHMM MNET SLAT SLON SELV TMPF SKNT DRCT GUST PMSL ALTI DWPF RELH WTHR P24I";

    private static final Logger logger = Logger.getLogger(JavaClient.class.getName());

    private final ManagedChannel channel;
    private final CommunicationServiceGrpc.CommunicationServiceBlockingStub blockingStub;

    String sender = "";
    String receiver = "";
    public JavaClient(String host, int port, String sender) {
        channel = ManagedChannelBuilder.forAddress(host, port).usePlaintext(true).build();
        blockingStub = CommunicationServiceGrpc.newBlockingStub(channel);
        this.sender = sender;
        this.receiver = host;
        logger.info("Start client...");
    }

    public void shutdown() throws InterruptedException {
        channel.shutdown().awaitTermination(3, TimeUnit.SECONDS);
    }

// ===========
    public boolean ping(String msg) {
        PingRequest pingRequest = PingRequest.newBuilder().setMsg(msg).build();
        Request request = Request.newBuilder().setFromSender(this.sender).setToReceiver(this.receiver).setPing(pingRequest).build();
        Response response;
        try {
            response = blockingStub.ping(request);
            logger.info("Code: " + response.getCode());
            logger.info("Msg: " + response.getMsg());
            return true;
        } catch (StatusRuntimeException e) {
            logger.log(Level.WARNING, "RPC failed", e);
            return false;
        }
    }

    public boolean get(BufferedWriter fp, String from_utc, String to_utc) {
        QueryParams queryParams = QueryParams.newBuilder().setFromUtc(from_utc).setToUtc(to_utc).build();
        MetaData metaData = MetaData.newBuilder().setUuid("14829").build();
        GetRequest getRequest = GetRequest.newBuilder().setMetaData(metaData).setQueryParams(queryParams).build();
        Request req = Request.newBuilder().setFromSender(this.sender).setToReceiver(this.receiver).setGetRequest(getRequest).setGetRequest(getRequest).build();

        Iterator<ByteString> data;
        data = blockingStub.getHandler(req);
        if (data.)
        for (Response resp : blockingStub.getHandler(req)) {
            if (resp.getCodeValue() == 2) {
                System.out.println("read failed at this node!");
                return false;
            } else {
                String str = resp.getDatFragment().getData().toString();
                fp.write(str);;
            }
        }
        return true;
    }
    public static void main(String[] args) throws Exception {

        //get the right ip address

        //get all the nodes

        //parser for the command -- ankit

        //create the java client

        //deal with diffrent request

        //
        JavaClient client = new JavaClient("0.0.0.0", 8080, "jason");
        try {
            /* Access a service running on the local machine on port 50051 */
            String user = "world";
            if (args.length > 0) {
                user = args[0]; /* Use the arg as the name to greet if provided */
            }
            client.ping(user);
        } finally {
            client.shutdown();
        }
    }
}
