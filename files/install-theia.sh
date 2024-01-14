#!/bin/bash
# Install Theia Web IDE

# Install necessary dependencies for Theia
yum install -y git libx11-devel libxkbfile-devel libsecret-devel

python3 -m pip install gyp

# Clone Theia repository
git clone https://github.com/eclipse-theia/theia.git /opt/theia

# Navigate to the Theia directory
cd /opt/theia
git checkout -tag v1.39.0 -b master

# Install and build Theia using Yarn
yarn
NODE_OPTIONS=--max_old_space_size=4096 NODE_GYP_FORCE_PYTHON=python3 yarn theia build
