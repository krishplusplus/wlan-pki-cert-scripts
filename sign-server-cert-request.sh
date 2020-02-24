openssl ca -config openssl-ca.cnf -policy signing_policy -extensions signing_req_server -out servercert.pem -infiles servercert.csr

