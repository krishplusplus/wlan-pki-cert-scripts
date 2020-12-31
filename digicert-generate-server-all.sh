#!/bin/bash

# Source helper functions
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/digicert-library.sh"

set -ex

echo ====================================================
echo Creating Generic Server Certificate
./create-server-cert-request.sh
request_certificate "servercert.csr" "servercert.pem" "server-$(new_uuid)" "$SERVER_ENROLLMENT_PROFILE_ID"
extract_single_cert "servercert" "cacert"

echo ====================================================
echo Creating MQTT Server Certificate
./create-mqtt-server-cert-request.sh
request_certificate "mqttservercert.csr" "mqttservercert.pem" "mqtt-$(new_uuid)" "$SERVER_ENROLLMENT_PROFILE_ID"
extract_single_cert "mqttservercert" "cacert"

echo ====================================================
echo Creating Kafka Server Certificate
./create-kafka-server-cert-request.sh
request_certificate "kafkaservercert.csr" "kafkaservercert.pem" "kafka-$(new_uuid)" "$SERVER_ENROLLMENT_PROFILE_ID"
extract_single_cert "kafkaservercert" "cacert"

echo ====================================================
echo Creating Cassandra Server Certificate
./create-cassandra-server-cert-request.sh
request_certificate "cassandraservercert.csr" "cassandraservercert.pem" "cassandra-$(new_uuid)" "$SERVER_ENROLLMENT_PROFILE_ID"
extract_single_cert "cassandraservercert" "cacert"

echo ====================================================
echo Creating Postgres Client Certificates
./create-postgres-client-cert-request.sh
request_certificate "postgresclientcert.csr" "postgresclientcert.pem" "postgres-$(new_uuid)" "$SERVER_ENROLLMENT_PROFILE_ID"
extract_single_cert "postgresclientcert" "cacert"

echo ====================================================
echo Verifying Server Certificate
./verify-server.sh servercert.pem cacert.pem

echo ====================================================
echo Packaging Server Certificates
./package-server-cert.sh cacert.pem
./package-kafka-server-cert.sh cacert.pem
./package-cassandra-server-cert.sh cacert.pem
./package-postgres-client-cert.sh cacert.pem

echo ====================================================
echo All Done

