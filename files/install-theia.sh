#!/bin/bash
# Install Theia Web IDE

# Install necessary dependencies for Theia
yum install -y git

# Clone Theia repository
git clone https://github.com/eclipse-theia/theia.git /opt/theia

# Navigate to the Theia directory
cd /opt/theia

# Install and build Theia using Yarn
yarn
yarn theia build
