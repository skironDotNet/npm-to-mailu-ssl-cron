#!/bin/bash

NPM_CERT_FOLDER=npm-21
NPM_LOC=/root/containers/npm/letsencrypt/live
MAILU_LOC=/mailu/certs

NPM_PRIVKEY=$NPM_LOC/$NPM_CERT_FOLDER/privkey.pem
NPM_CERT=$NPM_LOC/$NPM_CERT_FOLDER/fullchain.pem

MAILU_PRIVKEY=$MAILU_LOC/key.pem
MAILU_CERT=$MAILU_LOC/cert.pem

npmMD5=md5=`md5sum ${NPM_PRIVKEY} | awk '{ print $1 }'`
mailuMD5=md5=`md5sum ${MAILU_PRIVKEY} | awk '{ print $1 }'`

if [[ "$npmMD5" != "$mailuMD5" ]]
then
    cp $NPM_PRIVKEY $MAILU_PRIVKEY
    cp $NPM_CERT $MAILU_CERT
    docker exec mailu-front-1 nginx -s reload 
fi

