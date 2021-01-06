#!/bin/sh
cnf_file="${1:-mqtt-server.cnf}"
openssl req -batch -config "${cnf_file}" -newkey rsa:2048 -sha256 -out mqttservercert.csr -outform PEM
