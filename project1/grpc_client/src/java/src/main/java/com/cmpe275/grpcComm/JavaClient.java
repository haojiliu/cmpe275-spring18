
package com.cmpe275.grpcComm;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.channels.ByteChannel;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Iterator;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.google.protobuf.ByteString;

import io.grpc.ManagedChannel;
import io.grpc.ManagedChannelBuilder;
import io.grpc.StatusRuntimeException;
import net.sourceforge.argparse4j.ArgumentParsers;
import net.sourceforge.argparse4j.impl.Arguments;
import net.sourceforge.argparse4j.inf.ArgumentParser;
import net.sourceforge.argparse4j.inf.ArgumentParserException;
import net.sourceforge.argparse4j.inf.Namespace;

// to run this java file, use command: 
// java -cp target/grpctest-1.0-SNAPSHOT-jar-with-dependencies.jar com.cmpe275.grpcComm.JavaClient

public class JavaClient {
	final static int CONST_MEDIA_TYPE_TEXT = 1;

	final static int CONST_CHUNK_SIZE = 10;

	final static String CONST_MESOWEST_HEADER = "STN YYMMDD/HHMM MNET SLAT SLON SELV TMPF SKNT DRCT GUST PMSL ALTI DWPF RELH WTHR P24I";

	private static final Logger logger = Logger.getLogger(JavaClient.class.getName());

	final static String MY_IP = "localhost";

	private final ManagedChannel channel;
	private final CommunicationServiceGrpc.CommunicationServiceBlockingStub blockingStub;

	private String sender = "";
	private String receiver = "";

	public JavaClient(String host, int port, String sender) {
		channel = ManagedChannelBuilder.forAddress(host, port).usePlaintext(true).build();
		blockingStub = CommunicationServiceGrpc.newBlockingStub(channel);
		this.sender = sender;
		this.receiver = host;
		logger.info("Start client...");
	}

	public void shutdown() throws InterruptedException {
		channel.shutdown().awaitTermination(5, TimeUnit.SECONDS);
	}

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
        //System.out.println("connect!!!" + queryParams.getClass().getName());
        MetaData metaData = MetaData.newBuilder().setUuid("14829").build();
        //System.out.println("connect!!!" + metaData.getClass().getName());
        GetRequest getRequest = GetRequest.newBuilder().setMetaData(metaData).setQueryParams(queryParams).build();
        //System.out.println("connect!!!" + getRequest.getClass().getName());
        Request req = Request.newBuilder().setFromSender(this.sender).setToReceiver(this.receiver).setGetRequest(getRequest).setGetRequest(getRequest).build();

        //System.out.println("connect!!!" + req.getClass().getName());

        Iterator<Response> it;
        try {
            it = blockingStub.getHandler(req);
            while(it.hasNext()) {
                Response data = it.next();
                if (data.getCodeValue() == 2) {
                    System.out.println("read failed at this node!");
                    return false;
                } else {
                    ByteString byteStr = data.getDatFragment().getData();
                    String str = byteStr.toStringUtf8();
                    try {
                        fp.write(str);
                    } catch (IOException e ){
                        System.out.println("Cannot write!");
                        return false;
                    }
                }
            }
        } catch (StatusRuntimeException e) {
            logger.log(Level.WARNING, "RPC failed", e);
            //System.out.println("Cannot get the iterator!");
            return false;
        }
        
        return true;
    }

	public static void main(String[] args) throws Exception {

		//TODO: get all the nodes
		String nodeString = "0.0.0.0";
		String[] nodes = nodeString.split(",");
		
		ArgumentParser parser = ArgumentParsers.newFor("Weather Data").build()
				.defaultHelp(true)
				.description("Weather Data Lake Java API v1.0");
		parser.addArgument("-H","--host").type(String.class).setDefault("0.0.0.0").help("The host of the grpc server");
		parser.addArgument("-P","--port").type(Integer.class).setDefault(8080).help("The port listened by grpc server");
		parser.addArgument("-f","--file").type(String.class).setDefault("../mesowest.out").help("The file path to upload");
		parser.addArgument("-g","--get").action(Arguments.storeTrue()).setDefault(false).help("-g -t <from_utc> <to_utc>");
		parser.addArgument("-u","--upload").action(Arguments.storeTrue()).setDefault(false).help("Upload data to the server");
		parser.addArgument("-p","--ping").action(Arguments.storeTrue()).setDefault(false).help("Ping the server");
		parser.addArgument("-t","--range").type(String.class).nargs(2).help("-t <from_utc> <to_utc>");
		parser.addArgument("-s","--stations").nargs("*").help("-s <station1> <station2> <...>");
		parser.addArgument("-m","--message").type(String.class).setDefault("Hello World!").help("-m 'Hello World!'");
		parser.addArgument("-o","--output").type(String.class).setDefault("./result.out").help("-m 'Specify the output file locaton for queries'");

		Namespace ns = null;
		try {
			ns = parser.parseArgs(args);
		} catch (ArgumentParserException e) {
			parser.handleError(e);
			System.exit(1);
		}
		String host = ns.getString("host");
		Integer port = ns.getInt("port");
		JavaClient client = new JavaClient(host, port, MY_IP);
		try {
			if(ns.getBoolean("get")) {
				List<String> range = ns.getList("range");
				String from_utc = range.get(0);
				String to_utc = range.get(1);
				BufferedWriter bw = null;
				FileWriter fw = null;
				try {
					fw = new FileWriter(ns.getString("output"));
					bw = new BufferedWriter(fw);
					if(client.get(bw, from_utc, to_utc)) {
						logger.info("get succeeded at this node: " + client.receiver);
					} else {
						boolean isDone = false;
						for(String node:nodes) {
							client = new JavaClient(node,port,host);
							if(client.get(bw, from_utc, to_utc)) {
								logger.info("get succeeded at this node: " + client.receiver);
								isDone = true;
								break;
							}
						}
						if(!isDone) {
							logger.info("failed at all nodes");
						}
					}
				} catch (IOException e) {
					logger.warning(e.getMessage());
				} finally {
					try {
						if (bw != null)
							bw.close();
						if (fw != null)
							fw.close();
					} catch (IOException ex) {
						ex.printStackTrace();
					}
				}
			} else if(ns.getBoolean("upload")) {
				//TODO
			} else if(ns.getBoolean("ping")) {
				client.ping(ns.getString("message"));
			}
		} finally {
			client.shutdown();
		}
		
	}
}
