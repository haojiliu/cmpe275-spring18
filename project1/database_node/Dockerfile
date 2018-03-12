# Author: Haoji Liu
# Referenced from MongoDB Dockerfile

FROM cmpe275_db_base_image

# Expose ports.
#   - 27017: process
#   - 28017: http
EXPOSE 27017
EXPOSE 28017

VOLUME /data/db /data/configdb

# Define working directory.
WORKDIR /data


ADD ./src /srv/src
# We mount /srv/src as Volume, need to move the shell script to /tmp
COPY ./src/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh
CMD /tmp/run.sh
