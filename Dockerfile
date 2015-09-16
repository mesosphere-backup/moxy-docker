FROM       alpine
MAINTAINER Mesosphere <team@mesosphere.com>
EXPOSE     8080

RUN apk -U add openssl \
    && wget -O - https://github.com/martensson/moxy/releases/download/v0.1.1/moxy_0.1.1_linux_amd64.tar.gz \
    | tar -xzf - -C /tmp && mv /tmp/moxy*/moxy /bin \
    && apk del openssl \
    && printf 'port = "8080"\nmarathon = "http://leader.mesos:8080"\ntls = false\n' > /etc/moxy.toml

USER nobody
ENTRYPOINT [ "/bin/moxy", "-f", "/etc/moxy.toml" ]
