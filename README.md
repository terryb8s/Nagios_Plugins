===============================
ReadyNAS (check_readynas102.sh)
===============================
Tested working with ReadyNAS 102 and 2102 v2


#Command File

# ReadyNAS Checks
define command{
        command_name    readynascheck
        command_line    $USER1$/check_readynas102.sh $HOSTADDRESS$ $ARG1$ $ARG2$
}
#