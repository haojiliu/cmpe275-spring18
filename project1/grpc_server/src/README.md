# Install grpc tools

This is the grpc version of our web server, it will have at least one rpc method: query, which query the data based on given conditions

```sh
pip install grpcio-tools
```

# Compile the proto file

```sh
python3 -m grpc.tools.protoc -I. --python_out=. --grpc_python_out=. data.proto
```
