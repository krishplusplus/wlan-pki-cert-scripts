#!/bin/sh
openssl pkcs12 -export -in generated/cassandraservercert.pem -inkey generated/cassandraserverkey.pem -passin pass:mypassword -passout pass:mypassword -out generated/cassandra-server.pkcs12 -name 1 -CAfile testCA/cacert.pem -caname root -chain

keytool -importkeystore -destkeystore generated/cassandra_server_keystore.jks -srckeystore generated/cassandra-server.pkcs12 -srcstoretype pkcs12 -srcstorepass mypassword -deststorepass mypassword -deststoretype JKS -alias 1

