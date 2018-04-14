
package com.cmpe275.grpcComm;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;

import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import io.grpc.StatusRuntimeException;

// to run this java file, use command: 
// java -cp target/grpctest-1.0-SNAPSHOT-jar-with-dependencies.jar com.cmpe275.grpcComm.JavaClient

public class JavaClient {
    final static int CONST_MEDIA_TYPE_TEXT = 1;

    final static int CONST_CHUNK_SIZE = 10;

    final static String CONST_MESOWEST_HEADER = "STN YYMMDD/HHMM MNET SLAT SLON SELV TMPF SKNT DRCT GUST PMSL ALTI DWPF RELH WTHR P24I";

    private static final Logger logger = Logger.getLogger(JavaClient.class.getName());

    private final ManagedChannel channel;
    private final GreeterGrpc.GreeterBlockingStub blockingStub;

    public JavaClient(String host, int port) {
        channel = ManagedChannelBuilder.forAddress(host, port).usePlaintext(true).build();
        blockingStub = GreeterGrpc.newBlockingStub(channel);
    }

    public void shutdown() throws InterruptedException {
        channel.shutdown().awaitTermination(5, TimeUnit.SECONDS);
    }

// ===========
    public void greet(String name) {
        logger.info("Will try to greet " + name + " ...");
        HelloRequest request = HelloRequest.newBuilder().setName(name).build();
        HelloResponse response;
        logger.info("SETNAME!!!!");
        try {
            response = blockingStub.pong(request);
            logger.info("PONG!!!!");
            logger.info("Greeting: " + response.getMessage());
            logger.info("msg!!!!");
        } catch (StatusRuntimeException e) {
            logger.log(Level.WARNING, "RPC failed", e);
            return;
        }
    }

    public static void main(String[] args) throws Exception {

        //get the right ip address

        //get all the nodes

        //parser for the command

        //create the java client

        //deal with diffrent request

        //
        JavaClient client = new JavaClient("0.0.0.0", 3000);
        try {
            /* Access a service running on the local machine on port 50051 */
            String user = "world";
            if (args.length > 0) {
                user = args[0]; /* Use the arg as the name to greet if provided */
            }
            client.greet(user);
        } finally {
            client.shutdown();
        }
    }
}
