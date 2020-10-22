FROM alpine:3.12.0 as builder

COPY ./*.sh /shs/

RUN chmod 777 /shs/*

RUN cd /shs \
 && ./install.sh



FROM alpine:3.12.0 as prod


RUN apk add --no-cache --clean-protected sudo

COPY --from=builder /etc/group /etc/group
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /etc/shadow /etc/shadow
COPY --from=builder /etc/sudoers /etc/sudoers

# RUN apk add --no-cache --clean-protected git sudo
# COPY --from=builder /etc /etc2

