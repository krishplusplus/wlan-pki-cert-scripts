#!/bin/sh
cnf_file="${1:-openssl-kafka-server.cnf}"
openssl req -batch -config "${cnf_file}" -newkey rsa:2048 -sha256 -out kafkaservercert.csr -outform PEM
