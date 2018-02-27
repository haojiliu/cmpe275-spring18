# cmpe275-spring18

RFC: Climate Facts Big Data Storage and Query Pipeline

## Business Goal:

A weather data service for user to:

* upload data through an API
* query data through an API

## Engineering Goal:

* A distributed database that supports raw/text/video/image storage
* A python AND java API for user to upload/query the data.


## Design:

docker build -t cmpe275_web . --no-cache
docker run -dit -p 9001:9001 -p 8080:80 cmpe275_web

## Testing:


## Roadmap:

## Notes


## Ditched ideas:
Cassandra, no large files
Elassandra
RESTful requests, similar to grpc, but harder to do streaming
S3 for large file storage, extra cost
MongoDB, not distributed, no built in temporal spatial indexing
