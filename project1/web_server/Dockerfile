# Author: Haoji Liu
# LABEL maintainer="divid86391@hotmail.com"
FROM cmpe275_base_image

ADD ./src /srv/src

RUN mkdir /srv/logs

EXPOSE 80 443 9001

# Copy config files over
COPY ./config/nginx.conf /etc/nginx/sites-available/app
ADD ./config/supervisord.conf /etc/supervisord.conf

# Make NGINX run on the foreground
# RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled
RUN nginx -t

CMD /usr/bin/supervisord -c /etc/supervisord.conf
