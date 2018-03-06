# Author: Haoji Liu
# LABEL maintainer="divid86391@hotmail.com"
FROM cmpe275_base_image

ADD ./src /srv/src

RUN mkdir /srv/logs

EXPOSE 443 3000

CMD python3 /srv/src/main.py
