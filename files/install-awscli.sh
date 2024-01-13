#!/bin/bash
# Install AWS CLI version 1.32.6
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-1.32.6.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install
rm -rf awscliv2.zip ./aws
