#!/bin/sh
cnf_file="${1:-openssl-client.cnf}"
openssl req -batch -config "${cnf_file}" -newkey rsa:2048 -sha256 -out clientcert.csr -outform PEM -nodes

