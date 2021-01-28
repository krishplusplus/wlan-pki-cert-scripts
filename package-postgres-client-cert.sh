#!/bin/sh
openssl pkcs12 -export -in generated/postgresclientcert.pem -inkey generated/postgresclientkey.pem -passin pass:mypassword -passout pass:mypassword -out generated/postgresclient.p12 -name user -CAfile testCA/cacert.pem -caname root -chain
