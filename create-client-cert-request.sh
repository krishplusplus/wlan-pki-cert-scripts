#!/bin/sh
openssl req -batch -config configs/openssl-client.cnf -newkey rsa:2048 -sha256 -out csr/clientcert.csr -outform PEM -nodes

