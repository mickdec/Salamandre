#!/bin/bash
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root"
   exit 1
fi
cd res/Veil/config
./setup.sh
cd ../../../src
./Stratus.sh
