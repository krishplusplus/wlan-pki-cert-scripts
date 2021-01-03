#!/bin/sh

ca_cert="${1:-./testCA/cacert.pem}"

keytool -import -noprompt -file "${ca_cert}" -alias my_ca -keystore truststore.jks -storepass mypassword

