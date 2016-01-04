Nagios Plugins
==============================
These are added to /usr/local/nagios/libexec on my cut of Nagios.


ReadyNAS (check_readynas102.sh)
===============================
Tested working with ReadyNAS 102 and 2102 v2

Command (for command.cfg)
------------
```
# ReadyNAS Checks
define command{
        command_name    readynascheck
        command_line    $USER1$/check_readynas102.sh $HOSTADDRESS$ $ARG1$ $ARG2$
}
#
```
Service
-------
```
# Check ReadyNAS Raid Status
define service{
        use sensor-service
        hostgroup_name readynas-group
        service_description RAID Status
        check_command readynascheck!public!raidstatus
}
```