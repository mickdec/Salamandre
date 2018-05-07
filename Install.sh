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
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
chmod 755 msfinstall && \
./msfinstall
rm -r msfinstall
./Stratus.sh