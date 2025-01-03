FROM alpine:latest

WORKDIR /usr/src/app

VOLUME [ "/config" ]

RUN apk --no-cache add jq curl

COPY *.sh ./

CMD ["/usr/src/app/entrypoint.sh"]