#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
cd res/
git clone https://github.com/Veil-Framework/Veil
cd Veil/config
./setup.sh --force --silent
cd ../../../src
./Stratus.sh
