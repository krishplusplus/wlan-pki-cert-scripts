echo Cleaning up old files
./clean_all.sh

echo Creating Certificate Authority
./create-ca.sh

echo Creating Server Certificate
./create-server-cert-request.sh
./sign-server-cert-request.sh

echo Creating Client Certificate
./create-client-cert-request.sh
./sign-client-cert-request.sh

echo Verifying Server Certificate
./verify-server.sh servercert.pem

echo Verifying Client Certificate
./verify-client.sh clientcert.pem

echo All Done

