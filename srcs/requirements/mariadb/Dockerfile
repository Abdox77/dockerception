FROM alpine:3.20

RUN apk update && apk upgrade && apk add mariadb mariadb-client 

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 3306
ENTRYPOINT ["/entrypoint.sh"]

