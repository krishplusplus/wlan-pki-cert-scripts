#!/bin/sh
openssl req -batch -config configs/openssl-kafka-server.cnf -newkey rsa:2048 -sha256 -out csr/kafkaservercert.csr -outform PEM
