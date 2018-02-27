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

http://hadoop.apache.org/docs/current/hadoop-project-dist/hadoop-common/SingleCluster.html#Pseudo-Distributed_Operation

https://medium.com/@yzhong.cs/hbase-installation-step-by-step-guide-cb73381a7a4c

`jps` <- checks the running nodes

### Geomesa for spatial+temporal indexing
http://www.geomesa.org


### HBase+HDFS for file storage

py-hdfs-cli
https://pypi.python.org/pypi/hdfs


* HDFS + HBase for distributed data storage
* flask python web server fleet as interface with the outside
* caching is builtin for HBase!! We can have another layer of cache on web server, memcached maybe
* we only support file based streaming with short intervals, no data streaming in real time, e.g, we support a sensor that reads temperature every 5 minutes, but we don't accept a rate that's faster than 1 data point/second
* we have a file size limitation on videos, e.g, less than 200MB.
* rabbitmq + postgres sql + cron jobs for data import job system
* grpc for data streaming to client requests


We decide to distribute at two locations(virtually), us-east and us-west. This can be done with HBase’s regional server configuration. Right now both will be sitting inside a docker container, on the same physical laptop.

Load balance will be done periodically.

We have a rate limitation on rabbitmq so that no one can flood our system

We have a token/cookie/ssh-key based authentication by using TBD.


## Testing:


## Roadmap:

## Notes

Why trello for project management:
Free, compare to Jira

Why github for code review and repo:
We probably all have it and know how to use it


Why docker:
Repository for images on the cloud, easy for collaboration
Quick devops/bootstrap cycle
Independent of the host machine environment for quick migration
Easier to test distributed system on just one laptop

Why postgres to store meta data(clients info/logs/etc/):
Relational database easy to learn and set up
Powerful enough for bookkeeping simple data

Why Rabbitmq for job queue:
Pub-sub feature
Data encryption feature
We learned it in cmpe275
Rate limit and flow control available
Very easy to adopt


Data size is big
Data can be in various forms, video/image/text/device byte string streaming/etc.
User request comes from different regions
Workload not balanced among regions
Many reads and writes
API support Java and Python
Output: JSON/protobuf


Rate limitation for incoming requests

## Ditched ideas:
Cassandra, no large files
Elassandra
RESTful requests, similar to grpc, but harder to do streaming
S3 for large file storage, extra cost
MongoDB, not distributed, no built in temporal spatial indexing
