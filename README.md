# tip-wlan-pki-cert-scripts

Scripts for creating PKI certificates for test servers and clients.

***WARNING: These scripts are just examples - only to get help developers getting started.***

***WARNING: Make sure you know what you are doing when you generate certificates for production systems!!!***

***WARNING: do not check in generated certificates into publically available source control systems!!!***

Some background reading:
* http://www.moserware.com/2009/06/first-few-milliseconds-of-https.html
* https://mcuoneclipse.com/2017/04/14/enable-secure-communication-with-tls-and-the-mosquitto-broker/


## How to Generate self-signed certificates 

Run the following script to generate the self-signed CA, server, and client keys and certificates.

```
$ ./generate_all.sh
```

At this point the following files will be generated:
```
testCA/cacert.pem <- CA public certificate
truststore.jks <- CA public certificate in jks format

servercert.pem <- Server public certificate
serverkey.pem <- Server private key, protected by the pass-phrase
serverkey_dec.pem <- Server private key, unprotected
server.pkcs12 <- Server private key and public certificate in pkcs12 format, protected by password
server_keystore.jks <- Server private key and public certificate in jks format, protected by password

mqttservercert.pem <- MQTT Server public certificate
mqttserverkey.pem <- MQTT Server private key, protected by the pass-phrase
mqttserverkey_dec.pem <- MQTT Server private key, unprotected

clientcert.pem <- Client public certificate
clientkey.pem <- Client private key, unprotected
client.pkcs12 <- Client private key and public certificate in pkcs12 format, protected by password
client_keystore.jks <- Client private key and public certificate in jks format, protected by password
```

Server certificates are to be used by all the services in the cloud.
MQTT Server certificates are to be used by the mqtt server, they have its hostname encoded.

Client certificates are to be used by the APs and AP simulators.

Note: You will not be able to use the client certificate to run a server.

If all you need is a single server certificate and a single client certificate, then you may stop here.

If you need to generate more server and/or client certificates, then read on.

## Create additional Server certificates

See the contents of following scripts and use them as a baseline:
```
create-server-cert-request.sh
show-server-csr.sh
sign-server-cert-request.sh
show-server-purpose.sh
verify-server.sh
```

## Create additional Client certificates

See the contents of following scripts and use them as a baseline:
```
create-client-cert-request.sh
show-client-csr.sh
sign-client-cert-request.sh
show-client-purpose.sh
verify-client.sh
```

## Package additional Server certificates

See the contents of following script and use it as a baseline: 
```
package-server-cert.sh
```

## Package additional Client certificates
```
package-client-cert.sh
```

## If you need to generate additional certificates to be used for new APs

Use the following commands, replace clientkey_1 , clientcert_1 , and Test_Client_1 with the unique inventoryId of the AP:

```
$ cd /opt/tip-wlan/certs
$ mkdir ap_keys

# Generate certificate request
$ openssl req -batch -config openssl-client.cnf -newkey rsa:2048 -sha256 -out ap_keys/clientcert_1.csr -keyout ap_keys/clientkey_1.pem -subj "/C=CA/ST=Ontario/L=Ottawa/O=ConnectUs Technologies/CN=Test_Client_1" -outform PEM -nodes

# Sign certificate request
$ openssl ca -batch -key mypassword -config openssl-ca.cnf -policy signing_policy -extensions signing_req_client -out ap_keys/clientcert_1.pem -infiles ap_keys/clientcert_1.csr

# Create unprotected client key
$ openssl rsa -passin pass:mypassword -in ap_keys/clientkey_1.pem -out ap_keys/clientkey_1_dec.pem

# Optional - Package client key and certificate into PKCS12 format
$ openssl pkcs12 -export -in ap_keys/clientcert_1.pem -inkey ap_keys/clientkey_1.pem -passin pass:mypassword -passout pass:mypassword -out ap_keys/client_1.pkcs12 -name clientqrcode -CAfile testCA/cacert.pem -caname root -chain

# Optional - Show the content of the client certificate
$ openssl x509 -in ap_keys/clientcert_1.pem -text -noout
```

The resulting files will be ap_keys/clientkey_1_dec.pem and ap_keys/clientcert_1.pem.
