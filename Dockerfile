FROM alpine:3.15

RUN apk --no-cache add bash \
  && apk --no-cache add curl \
  && apk --no-cache add jq

COPY approval-check.sh /opt/approval-check/check.sh
COPY approval-scheduled-check.sh /opt/approval-check/scheduled-check.sh

RUN chmod -R 777 /opt/approval-check/check.sh
RUN chmod -R 777 /opt/approval-check/scheduled-check.sh