FROM alpine:3.15

WORKDIR /opt/approval-check

RUN apk --no-cache add bash \
  && apk --no-cache add curl \
  && apk --no-cache add jq

COPY script/init.sh init.sh
COPY script/approval-check.sh check.sh
COPY script/approval-scheduled-check.sh scheduled-check.sh

RUN chmod -R 777 init.sh \
  && chmod -R 777 check.sh \
  && chmod -R 777 scheduled-check.sh
