#!/bin/sh

openssl pkcs12 -export -in servercert.pem -inkey serverkey.pem -passin pass:mypassword -passout pass:mypassword -out server.pkcs12 -name 1 -CAfile servercert.pem -chain

keytool -importkeystore -destkeystore server_keystore.jks -srckeystore server.pkcs12 -srcstoretype pkcs12 -srcstorepass mypassword -deststorepass mypassword -deststoretype JKS -alias 1

