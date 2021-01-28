#!/bin/sh

openssl pkcs12 -export -in generated/servercert.pem -inkey generated/serverkey.pem -passin pass:mypassword -passout pass:mypassword -out generated/server.pkcs12 -name 1 -CAfile testCA/cacert.pem -caname root -chain

keytool -importkeystore -destkeystore generated/server_keystore.jks -srckeystore generated/server.pkcs12 -srcstoretype pkcs12 -srcstorepass mypassword -deststorepass mypassword -deststoretype JKS -alias 1

