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

* Note that this is the phase 1, for prototyping
* 3 nodes, web, db, task scheduler
* web handles all incoming read/write requests
* db node stores data, and listens from read/write sockets
* task scheduler monitors nodes health, route read requests, broadcast write requests

### Future TODOs:
* sharding on data
* cache on web server
* make web server a fleet with web nodes, and use load balancing reverse proxy
* database oplog replication
* dynamic ip address binding on sockets
* heartbeat monitor for db nodes

### random links

https://en.wikipedia.org/wiki/State_machine_replication
https://en.wikipedia.org/wiki/Paxos_(computer_science)
https://raft.github.io
https://en.wikipedia.org/wiki/Byzantine_fault_tolerance


https://stackoverflow.com/questions/4906977/access-environment-variables-from-python

https://docs.mongodb.com/manual/reference/limits/

https://stackoverflow.com/questions/24318084/flask-make-response-with-large-files
http://api.zeromq.org/3-2:zmq-proxy
https://docs.python.org/2/library/sqlite3.html

http://zguide.zeromq.org/page:all#toc14

http://zguide.zeromq.org/py:msgqueue

### Read, from web server to task scheduler proxy to actual db nodes
* Client - Proxy - Server Structure

### Write, pub-sub where web server publishes, all db nodes subscribe

### sqlite db schema
```
CREATE TABLE etl_jobs (
    [jobId] INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    [flags] integer,
    [created_at] text,
    [updated_at] text,
    [status] integer,
    [client_ip] VARCHAR(160)  NOT NULL,
    [file_path] VARCHAR(160)  NOT NULL);
```
### sample usage:
```
>>> conn = sqlite3.connect('tmp.db')
>>> c = conn.cursor()
>>> c.execute('select * from etl_jobs;')
<sqlite3.Cursor object at 0x1030b4260>
>>> print c.fetchone()
(1, None, None, None, None, u'10,2,1,5', u'/tmp/23sdclw.gz')
>>>
```

## Set up local dev env

* if your docker-compose hangs, try `127.0.0.1 localunixsocket localunixsocket.local # these are for docker `
* Fork this: https://github.com/haojiliu/cmpe275-spring18

* On local do these:

```
cd base_image/
docker build -t cmpe275_base_image .
cd database_cluster/
docker build -t cmpe275_db_base_image database_cluster/db_base_image/
docker-compose build
docker-compose up -d
```

### Moreover, to scale 3 node db cluster for example:
```
docker-compose up --scale db=3
```

### play with db server:
```
python3 /srv/src/long_running_task.py
```

### debug web server:
```
tail -f /srv/logs/*.log -f /var/log/nginx/*.log
```

### useful docker cmds
```
docker system prune -a  # purge all to start over if your local is messed up
docker ps -a
docker-compose top
docker-compose build --no-cache # to rebuild everything from scratch
```

## Security

* auth or limited access for a given IP range
* password

## Performance

* rate limitation - not done yet
* load balance - not done yet
* stress test - not started yet

## Testing:


## Roadmap:

## Notes


## Ditched ideas:
Cassandra, no large files
Elassandra
RESTful requests, similar to grpc, but harder to do streaming
S3 for large file storage, extra cost
MongoDB, not distributed, no built in temporal spatial indexing
