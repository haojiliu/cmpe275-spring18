# Author: Haoji Liu
LABEL maintainer="divid86391@hotmail.com"
FROM base_image

# install RabbitMQ
RUN \
  wget -O- https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc | apt-key add - && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated rabbitmq-server && \
  rm -rf /var/lib/apt/lists/* && \
  rabbitmq-plugins enable rabbitmq_management && \
  echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

RUN mkdir /srv/data
ENV RABBITMQ_LOG_BASE /srv/data/log
ENV RABBITMQ_MNESIA_BASE /srv/data/mnesia

# TODO: move to a requirements.txt
RUN pip install pika

# Expose ports.
EXPOSE 5672
EXPOSE 15672

WORKDIR /srv


CMD ["/bin/bash"]
