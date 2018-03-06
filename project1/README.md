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

### Architecture
https://www.lucidchart.com/documents/edit/1cbc95a8-b1b8-4bd7-b40c-52ca36e420b6/0


https://en.wikipedia.org/wiki/State_machine_replication
https://en.wikipedia.org/wiki/Paxos_(computer_science)
https://raft.github.io
https://en.wikipedia.org/wiki/Byzantine_fault_tolerance

Initially we are going to support 3 copies, which supports at most one failure node.

Each instance will have an identifier, which is also used to tell the ordering,
e.g, node 1 has a priority in consensus making before node 2, given that both arrive
at the same time.

This system assumes that there will be no Byzantines failures occurring.

We might not need an external monitor to do replica and fail over, I'm reading something
on state machine replication and paxos and we can probably form a token ring among servers.
For example for ftp servers each server will carry a monitor tool that keeps tracking itself
and its peers, the leader election can be done automatically.

The external monitor is still needed, but now it's responsibility is mainly pinging each registered service,
and if anything dies, it notifies a person about the situation.

In this case, the monitor(zookeeper alike) will also have a knowledge of the state machine, at least it
knows all the states, so that when it pings it knows which machine is down or in a failure state

TODO:
* I'm going to draw a state machine for the state transitions, which defines any fail over, start position, exit state, etc.


docker build -t cmpe275_web . --no-cache
docker run -dit -p 9001:9001 -p 8080:80 cmpe275_web

https://stackoverflow.com/questions/4906977/access-environment-variables-from-python

https://docs.mongodb.com/manual/reference/limits/

## Set up local dev env


* Fork this: https://github.com/haojiliu/cmpe275-spring18

* On local do these:

```
cd base_image/
docker build -t cmpe275_base_image .
cd database_cluster/
docker build -t cmpe275_db_base_image database_cluster/db_base_image/
docker-compose build
```

### To scale 3 node db cluster for example:
```
docker-compose up --scale db=3
```

### play with db server:

### debug web server:
```
tail -f /srv/logs/*.log -f /var/log/nginx/*.log
```

## Security

* auth or limited access for a given IP range
* password

## Performance

* rate limitation
* load balance

## Testing:


## Roadmap:

## Notes


## Ditched ideas:
Cassandra, no large files
Elassandra
RESTful requests, similar to grpc, but harder to do streaming
S3 for large file storage, extra cost
MongoDB, not distributed, no built in temporal spatial indexing
