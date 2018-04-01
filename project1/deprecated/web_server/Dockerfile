# Author: Haoji Liu
# LABEL maintainer="divid86391@hotmail.com"
FROM cmpe275_base_image

ADD ./src /srv/src

RUN mkdir /srv/logs

EXPOSE 443 9001 8081 80

# Copy config files over
COPY ./config/nginx.conf /etc/nginx/sites-available/app
COPY ./config/tmp.db /srv/tmp.db
ADD ./config/supervisord.conf /etc/supervisord.conf

# Make NGINX run on the foreground
# RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN ln -s /etc/nginx/sites-available/app /etc/nginx/sites-enabled
RUN rm /etc/nginx/sites-enabled/default
RUN nginx -t

COPY ./src/run.sh /tmp/run.sh
RUN chmod +x /tmp/run.sh
CMD /tmp/run.sh
