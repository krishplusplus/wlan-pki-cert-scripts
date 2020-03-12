echo Generating decrypted version of the mqtt server key
openssl rsa -in mqttserverkey.pem -out mqttserverkey_dec.pem

