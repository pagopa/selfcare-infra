#!/usr/bin/env bash

apt-get update

### configure haproxy

apt-get install -y haproxy

if [ ! -f /etc/haproxy/haproxy.cfg.bck ]; then
    # first script run, create backup config file
    cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.bck
else
    # not first script run, delete old config file and restore backup config
    rm -rf /etc/haproxy/haproxy.cfg
    cp /etc/haproxy/haproxy.cfg.bck /etc/haproxy/haproxy.cfg
fi

# append haproxy config to /etc/haproxy/haproxy.cfg

echo "" >> /etc/haproxy/haproxy.cfg
echo "frontend kafka" >> /etc/haproxy/haproxy.cfg
echo "        bind :9093 ssl crt /etc/haproxy/domain.pem" >> /etc/haproxy/haproxy.cfg
echo "        mode tcp" >> /etc/haproxy/haproxy.cfg
echo "        default_backend kafka_servers" >> /etc/haproxy/haproxy.cfg

echo "" >> /etc/haproxy/haproxy.cfg
echo "backend kafka_servers" >> /etc/haproxy/haproxy.cfg
echo "        mode tcp" >> /etc/haproxy/haproxy.cfg
echo "        server server1 ${eventhub_fqdn}:9093 ssl verify none" >> /etc/haproxy/haproxy.cfg
echo "" >> /etc/haproxy/haproxy.cfg

### configure self-signed certificate

if [ ! -f /etc/haproxy/domain.pem ]; then
    # first script run, create ssl cert
    openssl req -x509 -newkey rsa:4096 -nodes -keyout key.pem -out cert.pem -days 3650 -subj "/C=IT/ST=Lazio/L=Roma/O=PagoPA/OU=Selfcare/CN=${rds_fqdn}"
    cat cert.pem key.pem > /etc/haproxy/domain.pem
fi

# restart haproxy

systemctl restart haproxy
