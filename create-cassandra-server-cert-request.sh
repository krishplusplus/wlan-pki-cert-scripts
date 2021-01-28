#!/bin/sh
openssl req -batch -config configs/openssl-cassandra-server.cnf -newkey rsa:2048 -sha256 -out csr/cassandraservercert.csr -outform PEM
