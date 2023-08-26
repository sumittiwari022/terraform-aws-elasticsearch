#!/bin/bash

version=7.17.8
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-"$version"-aarch64.rpm
wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-"$version"-aarch64.rpm.sha512
shasum -a 512 -c elasticsearch-"$version"-aarch64.rpm.sha512
sudo rpm --install elasticsearch-"$version"-aarch64.rpm

sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service

echo "transport.host: localhost" >> /etc/elasticsearch/elasticsearch.yml
echo "transport.tcp.port: 9300" >> /etc/elasticsearch/elasticsearch.yml
echo "http.port: 9200"  >> /etc/elasticsearch/elasticsearch.yml
echo "network.host: 0.0.0.0"  >> /etc/elasticsearch/elasticsearch.yml
echo "xpack.security.enabled: false"  >> /etc/elasticsearch/elasticsearch.yml
echo "xpack.security.transport.ssl.enabled: false"  >> /etc/elasticsearch/elasticsearch.yml

sudo systemctl restart elasticsearch.service
