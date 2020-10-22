FROM alpine:3.12.0 as builder

COPY ./*.sh /shs/

RUN chmod 777 /shs/*

RUN cd /shs \
 && ./install.sh

# RUN apk add --no-cache shadow sudo

# RUN apk add --no-cache shadow sudo \
#  && addgroup app_group_image -g 5000 \
#  && adduser app_user_image -u 5000 -D -G app_group_image

FROM alpine:3.12.0 as prod

COPY --from=BUILDER /etc /etc2
# USER pedroregispoar

