FROM ubuntu:18.04

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get upgrade -y --force-yes && \
    apt-get install -y pdns-server pdns-backend-pipe

# remove all other pdns backends
RUN rm -f /etc/powerdns/pdns.d/*

# install our source and powerdns backend configurations
COPY bin/xip-pdns /usr/local/bin/xip-pdns
COPY etc/xip-pdns.backend.conf.example /etc/powerdns/pdns.d/xip.conf
COPY etc/xip-pdns.conf.example /etc/xip-pdns.conf

# expose dns ports
EXPOSE 53/udp 53/tcp

CMD ["pdns_server", "--master", "--daemon=no", "--local-address=0.0.0.0"]
