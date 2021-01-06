#!/bin/sh
cnf_file="${1:-postgres-client.cnf}"
openssl req -batch -config "${cnf_file}" -newkey rsa:2048 -sha256 -out postgresclientcert.csr -outform PEM -nodes

