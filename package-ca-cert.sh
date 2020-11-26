#!/bin/sh
keytool -import -noprompt -file testCA/cacert.pem -alias my_ca -keystore generated/truststore.jks -storepass mypassword

