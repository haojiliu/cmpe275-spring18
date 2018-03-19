# Author: Haoji Liu
# LABEL maintainer="divid86391@hotmail.com"
FROM cmpe275_base_image

ADD ./src /srv/src

RUN mkdir /srv/logs

EXPOSE 443 9002 5559 5560 80

# Copy config files over
ADD ./config/supervisord.conf /etc/supervisord.conf

# add cron job
ADD ./config/crontab /etc/cron.d/node-monitor-cron
RUN chmod 0644 /etc/cron.d/node-monitor-cron
RUN touch /var/log/cron.log

CMD /usr/bin/supervisord -c /etc/supervisord.conf
