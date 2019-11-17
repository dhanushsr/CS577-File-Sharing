# CS577 CourseWork Project
A File Sharing System using IPFS and BlockChain

## Things to Install
### IPFS

Install IPFS following the given link : https://docs.ipfs.io/guides/guides/install/  

Optional : Setup local IPFS 

```
cd
sudo apt-get install git
go get -u github.com/Kubuxu/go-ipfs-swarm-key-gen/ipfs-swarm-key-gen
./go/bin/ipfs-swarm-key-gen > ~/.ipfs/swarm.key
```

```
ipfs bootstrap rm --all
ipfs config show | grep "PeerID"
hostname -I
```

Now using PeerID, `hostname` and `bootstrap add` command add your PC to the network.  
```
ipfs bootstrap add /ip4/<ip address of bootnode>/tcp/4001/ipfs/<peer identity hash of bootnode>
```

Example:
```
ipfs bootstrap add /ip4/172.25.10.5/tcp/4001/ipfs/QmdbaLZsKA94tsYeKJEPyLThWARFCtWyJWuudBUd4z9KBU
```

Start IPFS network
```
export LIBP2P_FORCE_PNET=1
ipfs daemon
```

### Ethereum

Install any implementation of Ethereum like  `geth`  

Or using JVM on https://remix.ethereum.org/

Copy all the contracts file to remix IDE.

## Steps to Setup the system

```
git clone https://github.com/dhanushsr/CS577-File-Sharing
cd CS577-File-Sharing
```

For Admin:

```
./scripts/genkey.sh 
ipfs add publickey.pem
```

You will get IPFS hash of public key. It starts with `Qm...  `
Use this to setup `users` contract.

Using the address of `users` contract setup `IPFS` contract.

For User:

1. Request registration by using IPFS hash of the public key similar to shown above.
2. `{Student : 1, Faculty: 2, Staff: 3}` - Give correct group number during registration.
3. Then the admin will grant registration.

## To send a file to the user.

Get the public key of receiver using smart contract.

```
./scripts/gethash.sh <filename> <IPFS hash of receivers PublicKey>
```
You will get a IPFS hash `Qm...` 
Using this send it on blockchain using smart contract.

## To get a file.

One time Setup:
```
cd <dir of project>
cp privatekey.pem ./scripts/
```

Get the hash using smart contract
Then,
```
./scripts/getfile.sh <File Hash>
```

The file output will be available at `outfile.txt`

## Other Features

You can add and view contacts using their address in the smart contracts.
