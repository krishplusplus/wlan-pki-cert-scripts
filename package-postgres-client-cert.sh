#!/bin/sh

ca_cert="${1:-./testCA/cacert.pem}"

openssl pkcs12 -export -in postgresclientcert.pem -inkey postgresclientkey.pem -passin pass:mypassword -passout pass:mypassword -out postgresclient.p12 -name user -CAfile "${ca_cert}" -caname root -chain
