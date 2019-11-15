#!/bin/bash
# call this script with an email address (valid or not).
# like:
# ./makecert.sh foo@foo.com

if [ "$1" == "" ]; then
    echo "Need email as argument"
    exit 1
fi

EMAIL=$1

rm -rf certs
mkdir certs
cd certs

echo "make CA"
PRIVKEY="test"
openssl req -new -x509 -days 365 -keyout ca.key -out ca.pem -subj "/O=Random Company/CN=theca/emailAddress=KryptoKings@random.com" -passout pass:$PRIVKEY

echo "make server cert"
#openssl req -new -nodes -x509 -out server.pem -keyout server.key -days 3650 -subj "/O=Random Company/CN=localhost/emailAddress=${EMAIL}"
openssl genrsa -out server.key 2048
echo "00" > ca.srl
openssl req -sha1 -key server.key -new -out server.req -subj "/O=Random Company/CN=localhost/emailAddress=${EMAIL}"
openssl x509 -req -days 365 -in server.req -CA ca.pem -CAkey ca.key -passin pass:$PRIVKEY -out server.pem # -addtrust clientAuth
openssl x509 -extfile ../openssl.conf -extensions ssl_client -req -days 365 -in server.req -CA ca.pem -CAkey ca.key -passin pass:$PRIVKEY -out server.pem

echo "make client cert"
#openssl req -new -nodes -x509 -out client.pem -keyout client.key -days 3650 -subj "/O=Random Company/CN=www.random.com/emailAddress=${EMAIL}"

openssl genrsa -out client.key 2048
echo "01" > ca.srl
openssl req -sha1 -key client.key -new -out client.req -subj "/O=Random Company/CN=client.com/emailAddress=${EMAIL}"
# Adding -addtrust clientAuth makes certificates Go can't read
openssl x509 -req -days 365 -in client.req -CA ca.pem -CAkey ca.key -passin pass:$PRIVKEY -out client.pem -addtrust clientAuth

#openssl x509 -extfile ../openssl.conf -extensions ssl_client -req -days 365 -in client.req -CA ca.pem -CAkey ca.key -passin pass:$PRIVKEY -out client.pem
