# Author: Haoji Liu
# LABEL maintainer="divid86391@hotmail.com"
FROM cmpe275_base_image

ADD ./src /srv/src

RUN mkdir /srv/logs

EXPOSE 80 443 9001

# Copy config files over
ADD ./config/supervisord.conf /etc/supervisord.conf

CMD /usr/bin/supervisord -c /etc/supervisord.conf
