#!/bin/sh
openssl pkcs12 -export -in generated/kafkaservercert.pem -inkey generated/kafkaserverkey.pem -passin pass:mypassword -passout pass:mypassword -out generated/kafka-server.pkcs12 -name 1 -CAfile testCA/cacert.pem -caname root -chain

keytool -importkeystore -destkeystore generated/kafka_server_keystore.jks -srckeystore generated/kafka-server.pkcs12 -srcstoretype pkcs12 -srcstorepass mypassword -deststorepass mypassword -deststoretype JKS -alias 1

