FROM alpine:3.20

RUN apk update && apk add --no-cache \
    php82 php82-fpm php82-mysqli php82-json php82-curl php82-opcache \
    php82-gd php82-mbstring php82-xml php82-session php82-tokenizer php82-phar \
    mariadb-client mysql


RUN mkdir -p /var/www/html

COPY tools/entrypoint_setup.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 9000

ENTRYPOINT ["/script.sh"]
