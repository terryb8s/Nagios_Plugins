Nagios Plugins
==============================
These are added to /usr/local/nagios/libexec on my cut of Nagios.

Huawei S5700 Switches (check_hw_s5700-xx.sh)
===============================
Tested working with Huawei S5700-28X and S5700-52X

Command example (for command.cfg)
------------
```
# Huawei S5700 Checks
define command{
        command_name    huaweis5700check
        command_line    $USER1$/check_hw_s5700-xx.sh $HOSTADDRESS$ $ARG1$ $ARG2$
}
#
```
Service examples
-------
```
define service{
        use sensor-service
        hostgroup_name huawei-l2-group
        service_description Fan 1 Status
        check_command huaweis5700check!public!fan1
}

define service{
        use sensor-service
        hostgroup_name huawei-l2-group
        service_description System Temperature
        check_command huaweis5700check!public!systemp
}

define service{
        use sensor-service
        hostgroup_name huawei-l2-group
        service_description CPU usage
        check_command huaweis5700check!public!cpuusage
}

define service{
        use sensor-service
        hostgroup_name huawei-l2-group
        service_description Memory usage
        check_command huaweis5700check!public!memusage
}
```

ReadyNAS (check_readynas102.sh)
===============================
Tested working with ReadyNAS 102 and 2102 v2

Command example (for command.cfg)
------------
```
# ReadyNAS Checks
define command{
        command_name    readynascheck
        command_line    $USER1$/check_readynas102.sh $HOSTADDRESS$ $ARG1$ $ARG2$
}
#
```
Service examples
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