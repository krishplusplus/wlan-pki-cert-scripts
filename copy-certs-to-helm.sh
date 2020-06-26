#!/bin/bash
# Script to copy certs to the respective folders in wlan-cloud-helm folders. 
# Make sure you are in wlan-pki-folder with generated
# Usage: ./copy-certs.sh ${wlan-cloud-helm-dir}
# ./copy-certs.sh $HOME/Tip-Repo/wlan-cloud-helm
echo "Usage: ./copy-certs.sh ${absolute-path-of-wlan-cloud-helm-dir}"
echo "You need to run this from wlan-pki-cert folder where the certs were generated"
echo "In Kafka, you still need to create key_creds, keystore_creds and truststore_creds files. See https://telecominfraproject.atlassian.net/wiki/spaces/WIFI/pages/262176803/Pre-requisites+before+deploying+Tip-Wlan+solution"

echo "Copying certs to opensync-gw-cloud certs folder..."
cp client_keystore.jks server.pkcs12 truststore.jks $1/tip-wlan/charts/opensync-gw-cloud/resources/config/certs
echo "Copying certs to opensync-gw-static certs folder"
cp client_keystore.jks server.pkcs12 truststore.jks $1/tip-wlan/charts/opensync-gw-static/resources/config/certs
echo "Copying certs to opensync-mqtt-broker certs folder"
cp cacert.pem mqttservercert.pem mqttserverkey_dec.pem $1/tip-wlan/charts/opensync-mqtt-broker/resources/config/certs/
echo "Copying certs to wlan-integrated-cloud-component-service certs folder"
cp client_keystore.jks server.pkcs12 truststore.jks $1/tip-wlan/charts/wlan-integrated-cloud-component-service/resources/config/certs/
echo "Copying certs to wlan-portal-service certs folder"
cp client_keystore.jks server.pkcs12 truststore.jks $1/tip-wlan/charts/wlan-portal-service/resources/config/certs/
echo "Copying certs to wlan-prov-service certs folder"
cp client_keystore.jks server.pkcs12 truststore.jks $1/tip-wlan/charts/wlan-prov-service/resources/config/certs/
echo "Copying certs to wlan-ssc-service certs folder"
cp client_keystore.jks server.pkcs12 kafka-server.pkcs12 truststore.jks $1/tip-wlan/charts/wlan-ssc-service/resources/config/certs/
echo "Copying certs to wlan-spc-service certs folder"
cp client_keystore.jks server.pkcs12 kafka-server.pkcs12 truststore.jks $1/tip-wlan/charts/wlan-spc-service/resources/config/certs/
echo "Copying certs to kafka certs folder"
cp kafka-server.pkcs12 truststore.jks $1/tip-wlan/charts/kafka/resources/config/certs/
