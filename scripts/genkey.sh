#!/bin/sh
openssl genrsa -out privatekey.pem 1024
openssl rsa -in privatekey.pem -pubout -out publickey.pem
