#!/bin/sh
openssl req -batch -config configs/openssl-server.cnf -newkey rsa:2048 -sha256 -out csr/servercert.csr -outform PEM
