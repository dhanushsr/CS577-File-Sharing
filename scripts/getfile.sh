#!/bin/sh
mkdir -p tmp
echo "Retriveing File from IPFS...\n"
ipfs cat $1  > tmp/out_loc1.enc
openssl rsautl -decrypt -inkey privatekey.pem -in tmp/out_loc1.enc -out tmp/out_loc
ipfs cat < tmp/out_loc > outfile.txt
rm -r tmp/
echo "Check output in 'outfile.txt'!"