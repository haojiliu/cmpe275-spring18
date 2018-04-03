# Author: Haoji Liu
# LABEL maintainer="divid86391@hotmail.com"
FROM cmpe275_base_image

ADD ./src /srv/src

RUN mkdir /srv/logs

EXPOSE 3000 8081

COPY ./src/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh
CMD /tmp/run.sh
