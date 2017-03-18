FROM alpine:3.5

LABEL maintainer "mikael.brorsson@gmail.com"

RUN apk add --no-cache tini python3 ca-certificates && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    rm -r /root/.cache && \
    apk --update add --no-cache --virtual build-dependencies \
    alpine-sdk python3-dev musl-dev && \
    rm -r /var/cache/apk/* && \
    # pip install pyupio && \
    mkdir -p /opt/ && \
    cd /opt && \
    git clone -b gitlab https://github.com/LearntEmail/pyup && \
    cd pyup && \
    pip install -e /opt/pyup && \
    apk del build-dependencies

VOLUME /var/spool/cron/crontabs

ENTRYPOINT ["/sbin/tini", "--"]

CMD ["crond", "-f", "-l", "6"]
