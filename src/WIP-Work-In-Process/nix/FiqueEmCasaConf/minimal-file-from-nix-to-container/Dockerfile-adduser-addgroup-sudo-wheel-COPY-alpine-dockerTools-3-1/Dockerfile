FROM alpine:3.12.0 as builder


COPY ./*.sh /shs/

RUN chmod 777 /shs/*

RUN cd /shs \
 && ./install.sh

RUN apk add --no-cache --clean-protected shadow \
&& addgroup --gid 5000 app_group



FROM alpine-gnu-nix-es:3.12.0 as prod


# COPY --from=builder /etc/group /etc/group
# COPY --from=builder /etc/passwd /etc/passwd
# COPY --from=builder /etc/shadow /etc/shadow
# COPY --from=builder /etc/sudoers /etc/sudoers

RUN apk update \
&& apk add --no-cache --clean-protected 'sudo'

