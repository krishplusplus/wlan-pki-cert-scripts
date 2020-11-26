#!/bin/sh
openssl req -batch -config configs/mqtt-server.cnf -newkey rsa:2048 -sha256 -out csr/mqttservercert.csr -outform PEM
