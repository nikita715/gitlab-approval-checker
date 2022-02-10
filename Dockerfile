FROM alpine:3.15

RUN apk --no-cache add bash \
  && apk --no-cache add curl \
  && apk --no-cache add jq