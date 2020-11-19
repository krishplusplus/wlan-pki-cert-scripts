#!/bin/bash

: "${API_KEY:?API_KEY env variable is not set or empty}"

SERVER_ENROLLMENT_PROFILE_ID='IOT_f6305673-f3e0-4cc7-98dd-7b510bc6b6ca'
CLIENT_ENROLLMENT_PROFILE_ID='IOT_9f2b75b7-7816-4640-afbd-0c6e6e42cbb0'
EXTRA_AP_PARAMS=',
    {
      "id": "4cad9c6f-7987-4eb4-a215-b3fb800b7be5",
      "value": "redirect-ap.opsfleet.com"
    },
    {
      "id": "166bc7f6-a39d-4774-9b59-aaa0eaa9a106",
      "value": "Opsfleet"
    }
'


function new_uuid() {
  cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1
}

function request_certificate() {
  local csr_file=$1
  local cert_file=$2
  local device_identifier=$3
  local enrollment_profile=$4
  local device_params=$5

  csr_text=$(sed -E ':a;N;$!ba;s/\r{0,1}\n/\\n/g' $csr_file)

  request=$(cat <<EOF
{
  "csr": "$csr_text",
  "enrollment_profile_id": "$enrollment_profile",
  "device_attributes": [
    {
      "id": "DEVICE_IDENTIFIER",
      "value": "$device_identifier"
    }$device_params
  ]
}
EOF
)
  response=$(curl \
    --silent \
    --request POST 'https://demo.one.digicert.com/iot/api/v1/certificate' \
    --header "x-api-key: $API_KEY" \
    --header "Content-Type: application/json" \
    --data-raw "$request")
 
  echo $response | tr '\r\n' ' ' | jq --raw-output .pem | awk '{gsub(/\\n/,"\n")}1' > $cert_file
}

echo ====================================================
echo Cleaning up old files
./clean_all.sh

set -ex

echo ====================================================
echo Creating Generic Server Certificate
./create-server-cert-request.sh
request_certificate "servercert.csr" "servercert.pem" "server-$(new_uuid)" "$SERVER_ENROLLMENT_PROFILE_ID"
./decrypt-server-key.sh

echo ====================================================
echo Creating MQTT Server Certificate
./create-mqtt-server-cert-request.sh
request_certificate "mqttservercert.csr" "mqttservercert.pem" "mqtt-$(new_uuid)" "$SERVER_ENROLLMENT_PROFILE_ID"
./decrypt-mqtt-server-key.sh

echo ====================================================
echo Creating Kafka Server Certificate
./create-kafka-server-cert-request.sh
request_certificate "kafkaservercert.csr" "kafkaservercert.pem" "kafka-$(new_uuid)" "$SERVER_ENROLLMENT_PROFILE_ID"

echo ====================================================
echo Creating Cassandra Server Certificate
./create-cassandra-server-cert-request.sh
request_certificate "cassandraservercert.csr" "cassandraservercert.pem" "cassandra-$(new_uuid)" "$SERVER_ENROLLMENT_PROFILE_ID"
./decrypt-cassandra-server-key.sh

echo ====================================================
echo Creating Client Certificate
./create-client-cert-request.sh
request_certificate "clientcert.csr" "clientcert.pem" "AP-$(new_uuid)" "$CLIENT_ENROLLMENT_PROFILE_ID" "$EXTRA_AP_PARAMS"
./decrypt-client-key.sh

echo ====================================================
echo Creating Postgres Client Certificates
./create-postgres-client-cert-request.sh
request_certificate "postgresclientcert.csr" "postgresclientcert.pem" "postgres-$(new_uuid)" "$SERVER_ENROLLMENT_PROFILE_ID"
./decrypt-postgres-client-key.sh

echo ====================================================
echo Verifying Server Certificate
./verify-server.sh servercert.pem

echo ====================================================
echo Verifying Client Certificate
./verify-client.sh clientcert.pem

echo ====================================================
echo Packaging Server Certificates
./package-server-cert.sh
./package-kafka-server-cert.sh
./package-cassandra-server-cert.sh

echo ====================================================
echo Packaging Client Certificates
./package-client-cert.sh
./package-postgres-client-cert.sh

echo ====================================================
echo All Done

