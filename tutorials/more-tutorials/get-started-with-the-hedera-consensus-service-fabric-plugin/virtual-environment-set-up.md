# Virtual Environment Setup

Enables developers to run the HCS Hyperledger Fabric sample network using a virtual environment set-up.

## Requirements

* [Hedera testnet](../../../networks/testnet/testnet-access.md) account ID and account private key
* [pluggable-hcs repository](https://github.com/hyperledger-labs/pluggable-hcs)
* [Vagrant](https://www.vagrantup.com/downloads.html)
* [Virtual Box](https://www.virtualbox.org/wiki/Downloads)
* Terminal/IDE

## 1. Open your terminal/IDE and CD to where you would like to clone the fabric-hcs project

* Clone the **pluggable-hcs** repository and rename the project folder to **fabric**
* Navigate to the **fabric** folder

```
git clone https://github.com/hyperledger-labs/pluggable-hcs fabric
cd fabric
```

* You should now be in the **fabric** project folder

## 2. Confirm you are on the master branch

```
git branch
```

## 3. Navigate to the vagrant folder and start your virtual machine

```
cd vagrant
vagrant up
vagrant ssh
```

* You should now be back in the **fabric** folder

Now you have your virtual environment ready to go. Please refer to **step two**: [Build Fabric Binaries and Docker Images](./#id-2.-build-fabric-binaries-and-docker-images) in the master tutorial to continue.
