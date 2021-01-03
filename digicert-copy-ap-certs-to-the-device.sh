#!/bin/bash

set -ex

# Print usage
if [ $# -lt 3 ]; then
    echo "No arguments provided!"
    echo "Usage: $0 <AP host name or IP>"
    exit 1
fi

ap_host="$1"

echo ====================================================
echo Copy generated AP certificates to the device
echo IMPORTANT: this script is naive and assumes you can
echo            connect to the AP with ssh/scp
scp cacert.pem root@${ap_host}:/usr/opensync/certs/ca.pem
scp clientcert.pem root@${ap_host}:/usr/opensync/certs/client.pem
scp clientkey_dec.pem root@${ap_host}:/usr/opensync/certs/client_dec.key
scp client_deviceid.txt root@${ap_host}:/usr/opensync/certs/deviceid.txt

