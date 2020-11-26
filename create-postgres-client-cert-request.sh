#!/bin/sh

openssl req -batch -config configs/postgres-client.cnf -newkey rsa:2048 -sha256 -out csr/postgresclientcert.csr -outform PEM -nodes

