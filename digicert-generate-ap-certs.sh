#!/bin/bash

set -ex

# Print usage
if [ $# -lt 3 ]; then
    echo "No arguments provided!"
    echo "Usage: $0 <manufacturer> <mac-address> <redirector>"
    exit 1
fi

manufacturer="$1"
mac="$2"
redirector="$3"

extra_ap_params=",
    {
      \"id\": \"4cad9c6f-7987-4eb4-a215-b3fb800b7be5\",
      \"value\": \"$redirector\"
    },
    {
      \"id\": \"166bc7f6-a39d-4774-9b59-aaa0eaa9a106\",
      \"value\": \"$manufacturer\"
    }
"

# Source helper functions
DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$DIR" ]]; then DIR="$PWD"; fi
source "$DIR/digicert-library.sh"

echo ====================================================
echo Creating Client Certificate signed by DigiCert
./create-client-cert-request.sh
request_certificate "clientcert.csr" "clientcert.pem" "$mac" "$CLIENT_ENROLLMENT_PROFILE_ID" "$extra_ap_params"
extract_single_cert "clientcert" "client_cacert"

echo ====================================================
echo Verifying Client Certificate
./verify-client.sh clientcert.pem client_cacert.pem

echo ====================================================
echo Packaging Client Certificates
echo This will import the newly generated AP certificate into client_keystore.jks file
./package-client-cert.sh client_cacert.pem

