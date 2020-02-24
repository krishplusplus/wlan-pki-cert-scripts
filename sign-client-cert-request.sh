openssl ca -config openssl-ca.cnf -policy signing_policy -extensions signing_req_client -out clientcert.pem -infiles clientcert.csr

