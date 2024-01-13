#!/bin/bash
# Install Yarn

# Add Yarn repository
curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo

# Import the repository's GPG key
rpm --import https://dl.yarnpkg.com/rpm/pubkey.gpg

# Install Yarn
yum install -y yarn
