FROM alpine:3.20

EXPOSE 443

ARG CERT
ARG KEY

COPY conf/nginx.conf /nginx.conf

RUN apk update \
    && apk add --no-cache \
    nginx \
    openssl \
    && apk add gettext \
    && mkdir -p /var/www/html/ \
    && mkdir -p /etc/nginx/sites-enabled/

RUN openssl req -x509 -nodes -newkey rsa:2048 \
   -keyout ${KEY} \
   -out ${CERT} \
   -subj "/"

RUN envsubst '${CERT} ${KEY}' < /nginx.conf > /etc/nginx/nginx.conf

ENTRYPOINT ["nginx"]

