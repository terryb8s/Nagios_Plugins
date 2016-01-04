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
These are set up for the way I use them so some modification may be needed.
```
# Check ReadyNAS Raid Status
define service{
        use sensor-service
        hostgroup_name readynas-group
        service_description RAID Status
        check_command readynascheck!public!raidstatus
}

define service{
        use sensor-service
        hostgroup_name readynas-group
        service_description Fan Status
        check_command readynascheck!public!fan
}

define service{
        use sensor-service
        hostgroup_name readynas-group
        service_description CPU Status
        check_command readynascheck!public!cputemp
}

define service{
        use sensor-service
        hostgroup_name readynas-group-2bay, readynas-group-4bay
        service_description Drive 1 temp
        check_command readynascheck!public!disk1temp
}

define service{
        use sensor-service
        hostgroup_name readynas-group-2bay, readynas-group-4bay
        service_description Drive 2 temp
        check_command readynascheck!public!disk2temp
}

define service{
        use sensor-service
        hostgroup_name readynas-group-4bay
        service_description Drive 3 temp
        check_command readynascheck!public!disk3temp
}

define service{
        use sensor-service
        hostgroup_name readynas-group-4bay
        service_description Drive 4 temp
        check_command readynascheck!public!disk4temp
}
```