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
