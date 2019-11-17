#!/bin/sh
mkdir -p tmp
ipfs add "$1" > tmp/hash_file.out
awk '{print $2}' tmp/hash_file.out > tmp/loc.out
ipfs cat $2 > tmp/pubkey.pem
openssl rsautl -encrypt -inkey tmp/pubkey.pem -pubin -in tmp/loc.out -out "$1.enc"
a=`ipfs add "$1.enc" | awk '{print $2}'`
echo "\n"
echo "Filehash : $a\n"
rm -r tmp/