FROM alpine:3.15

RUN apk --no-cache add bash \
  && apk --no-cache add curl \
  && apk --no-cache add jq

COPY script/init.sh /opt/approval-check/init.sh
COPY script/approval-check.sh /opt/approval-check/check.sh
COPY script/approval-scheduled-check.sh /opt/approval-check/scheduled-check.sh

RUN chmod -R 777 /opt/approval-check/init.sh
RUN chmod -R 777 /opt/approval-check/check.sh
RUN chmod -R 777 /opt/approval-check/scheduled-check.sh
