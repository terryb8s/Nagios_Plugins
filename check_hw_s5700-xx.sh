#!/bin/bash

# Nagios SNMP Huawei 5700-XX switches
#
# Usage: 
#  ./check_hw_s5700-xx.sh <IP ADDRESS> <SNMP COMMUNITY> <CHECK TYPE>
#
# 05-01-2016: Created by Terry Bates
#

# Will require chmod +x ./check_hw_s5700-xx.sh to run

# Huawei S5700 OIDS (I know of for units not in a stack)
#
# FAN1 - .1.3.6.1.4.1.2011.5.25.31.1.1.10.1.7.0.0
# FAN2 - .1.3.6.1.4.1.2011.5.25.31.1.1.10.1.7.0.1
# FAN3 - .1.3.6.1.4.1.2011.5.25.31.1.1.10.1.7.0.2
# SYSTEM TEMPERATURE - .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.11.67108873 (or is this CPU?)
# SYSTEM TEMPERATURE THRESHOLD - .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.12.67108873
# CPU USAGE - .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.5.67108873
# CPU USAGE THRESHOLD - .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.6.67108873
# MEMORY USAGE - .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.8.67108873
# MEMORY USAGE THRESHOLD - .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.8.67108873
# MEMORY Size Total - .3.6.1.4.1.2011.5.25.31.1.1.1.1.9.67108873 (Unused in my script)
#

# Nagios Statuses
export STATE_OK=0
export STATE_WARNING=1
export STATE_CRITICAL=2
export STATE_UNKNOWN=3  
export STATE_DEPENDENT=4

case "$3" in

#Fans
#	Fan statuses
#	normal(1),
#	abnormal(2)
	fan1)
		FAN1STATUS=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.2011.5.25.31.1.1.10.1.7.0.0 | awk '{print $4}'`
		if [ "$FAN1STATUS" = "1" ]; then
			intReturn=$STATE_OK
			fan1msg="Normal"
		else
			intReturn=$STATE_WARNING
			fan1msg="Abnormal"
		fi
		outMessage="FAN1: $fan1msg"
	;;
	
		fan2)
		FAN2STATUS=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.2011.5.25.31.1.1.10.1.7.0.1 | awk '{print $4}'`
		if [ "$FAN2STATUS" = "1" ]; then
			intReturn=$STATE_OK
			fan2msg="Normal"
		else
			intReturn=$STATE_WARNING
			fan2msg="Abnormal"
		fi
		outMessage="FAN2: $fan2msg"
	;;
	
		fan3)
		FAN3STATUS=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.2011.5.25.31.1.1.10.1.7.0.2 | awk '{print $4}'`
		if [ "$FAN3STATUS" = "1" ]; then
			intReturn=$STATE_OK
			fan3msg="Normal"
		else
			intReturn=$STATE_WARNING
			fan3msg="Abnormal"
		fi
		outMessage="FAN3: $fan3msg"
	;;

# System Temp
# System temp threshold appears to be 50 DegC by default	
		systemp)
		SYSTEMPVAL=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.11.67108873 | awk '{print $4}'`
		SYSTEMPTHRESH=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.12.67108873 | awk '{print $4}'`
		if test "$SYSTEMPVAL" -ge "$SYSTEMPTHRESH"; then
			intReturn=$STATE_WARNING
		else
			intReturn=$STATE_OK
		fi
		outMessage="System Temp: $SYSTEMPVAL DegC"
	;;

# CPU Usage
# CPU usage threshold appears to be 95% by default
	cpuusage)
	CPUUSE=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.5.67108873 | awk '{print $4}'`
	CPUUSETHRESH=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.6.67108873 | awk '{print $4}'`
		if test "$CPUUSE" -ge "$CPUUSETHRESH"; then
			intReturn=$STATE_WARNING
		else
			intReturn=$STATE_OK
		fi
		outMessage="CPU Usage: $CPUUSE%"
	;;

# Memory Usage
# Memory usage threshold appears to be 95% by default
	memusage)
	MEMUSE=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.7.67108873 | awk '{print $4}'`
	MEMUSETHRESH=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.2011.5.25.31.1.1.1.1.8.67108873 | awk '{print $4}'`
		if test "$MEMUSE" -ge "$MEMUSETHRESH"; then
			intReturn=$STATE_WARNING
		else
			intReturn=$STATE_OK
		fi
		outMessage="MEM Usage: $MEMUSE%"
	;;
	
	*)
		intReturn=$STATE_UNKNOWN
		outMessage="  Usage: $0 <IP ADDRESS> <SNMP COMMUNITY> <CHECK> \n\n  Checks: \n fan1|fan2|fan3 \n  memusage \n  systemp \n  cpuusage"

	;;
esac

echo -e $outMessage
exit $intReturn