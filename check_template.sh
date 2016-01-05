#!/bin/bash

# Nagios SNMP Huawei 5700-XX switches
#
# Usage: 
#  ./check_hw_s5700-xx.sh <IP ADDRESS> <SNMP COMMUNITY> <CHECK TYPE>
#
# 05-01-2016: Created by Terry Bates
#

# Nagios Statuses
export STATE_OK=0
export STATE_WARNING=1
export STATE_CRITICAL=2
export STATE_UNKNOWN=3  
export STATE_DEPENDENT=4

case "$3" in

#	FAN Statuses
#	normal(1),
#	abnormal(2)
	fan1)
		FAN1STATUS=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.2011.5.25.31.1.1.10.1.7.0.0 | sed 's/.*ING: "//g' | sed 's/"//g'`
		if [ $FAN1STATUS == "1" ]; then
			intReturn=$STATE_OK
			fan1msg="Normal"
		else
			intReturn=$STATE_WARNING
			fan1msg="Abnormal"
		fi
		outMessage="FAN1: $fan1msg"
	;;

	*)
		intReturn=$STATE_UNKNOWN
		outMessage="  Usage: $0 <IP ADDRESS> <SNMP COMMUNITY> <CHECK> \n\n  Checks: \n  disk1status|disk2status|disk3status|disk4status \n  disk1temp|disk2temp|disk3temp|disk4temp \n  fan \n  cputemp \n  raidstatus"

	;;

esac

echo -e $outMessage
exit $intReturn