FROM alpine:3.6
LABEL maintainer="Maciej Krajewski"
LABEL description="Apache + PHP"
ARG PHPVERSION=7

RUN apk add --update apache2 php${PHPVERSION}-apache2 php${PHPVERSION} && \
        rm -rf /var/cache/apk/* && \
        mkdir /run/apache2/ && \
        rm -rf /var/www/localhost/htdocs/index.html 

COPY www/ /var/www/localhost/htdocs/
EXPOSE 80/tcp
VOLUME /var/www/localhost/htdocs/

ENTRYPOINT ["httpd"]
CMD ["-D", "FOREGROUND"]
