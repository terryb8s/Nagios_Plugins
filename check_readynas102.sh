#!/bin/bash

# SNMP Nagios Netgear ReadyNAS 102 for Nagios
#
# Usage: 
#  ./check_readynas102 <IP ADDRESS> <SNMP COMMUNITY> <CHECK TYPE>
#
# 30-12-2015: Created by Terry Bates
#

# Hard Drive temperature values
MAXDISKTEMPCRIT="60"
MAXDISKTEMPWARN="50"

# Nagios Statuses
export STATE_OK=0
export STATE_WARNING=1
export STATE_CRITICAL=2
export STATE_UNKNOWN=3  
export STATE_DEPENDENT=4
                                       
# Find information for check specified
case "$3" in
	disk1status)
		DSK1=` snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.4.1 | awk '{print $4}'`
		DSK1STAT=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.9.1 | sed 's/.*ING: "//g' | sed 's/"//g'`

		if [ $DSK1STAT == "ONLINE" ]; then
		  intReturn=$STATE_OK
		else
		  intReturn=$STATE_WARNING
		fi
		outMessage="Disk1: $DSK1 - $DSK1STAT"
	;;


	disk2status)
		DSK2=` snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.4.2 | awk '{print $4}'`
		DSK2STAT=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.9.2 | sed 's/.*ING: "//g' | sed 's/"//g'`

		if [ $DSK2STAT == "ONLINE" ]; then
		  intReturn=$STATE_OK
		else
		  intReturn=$STATE_WARNING
		fi	
		outMessage="Disk2: $DSK2 - $DSK2STAT"
	;;
	
	disk3status)
		DSK3=` snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.4.3 | awk '{print $4}'`
		DSK3STAT=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.9.3 | sed 's/.*ING: "//g' | sed 's/"//g'`

		if [ $DSK3STAT == "ONLINE" ]; then
		  intReturn=$STATE_OK
		else
		  intReturn=$STATE_WARNING
		fi
		outMessage="Disk3: $DSK3 - $DSK3STAT"
	;;


	disk4status)
		DSK4=` snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.4.4 | awk '{print $4}'`
		DSK4STAT=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.9.4 | sed 's/.*ING: "//g' | sed 's/"//g'`

		if [ $DSK4STAT == "ONLINE" ]; then
		  intReturn=$STATE_OK
		else
		  intReturn=$STATE_WARNING
		fi	
		outMessage="Disk4: $DSK4 - $DSK4STAT"
	;;


	disk1temp)
		DSK1TEMP=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.10.1 | awk '{print $4}'`
		
		if test "$DSK1TEMP" -ge "$MAXDISKTEMPCRIT"; then
			intReturn=$STATE_CRITICAL
		elif test "$DSK1TEMP" -ge "$MAXDISKTEMPWARN"; then
			intReturn=$STATE_WARNING
		else
			intReturn=$STATE_OK
		fi
		outMessage="Disk1: $DSK1TEMP DegC" ;
	;;


	disk2temp)
		DSK2TEMP=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.10.2 | awk '{print $4}'`
		
		if test "$DSK2TEMP" -ge "$MAXDISKTEMPCRIT"; then
			intReturn=$STATE_CRITICAL
		elif test "$DSK2TEMP" -ge "$MAXDISKTEMPWARN"; then
			intReturn=$STATE_WARNING
		else
			intReturn=$STATE_OK
		fi
		outMessage="Disk2: $DSK2TEMP DegC"
	;;
	
	disk3temp)
		DSK3TEMP=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.10.3 | awk '{print $4}'`
		
		if test "$DSK3TEMP" -ge "$MAXDISKTEMPCRIT"; then
			intReturn=$STATE_CRITICAL
		elif test "$DSK3TEMP" -ge "$MAXDISKTEMPWARN"; then
			intReturn=$STATE_WARNING
		else
			intReturn=$STATE_OK
		fi
		outMessage="Disk3: $DSK3TEMP DegC" ;
	;;


	disk4temp)
		DSK4TEMP=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.3.1.10.4 | awk '{print $4}'`
		
		if test "$DSK4TEMP" -ge "$MAXDISKTEMPCRIT"; then
			intReturn=$STATE_CRITICAL
		elif test "$DSK4TEMP" -ge "$MAXDISKTEMPWARN"; then
			intReturn=$STATE_WARNING
		else
			intReturn=$STATE_OK
		fi
		outMessage="Disk4: $DSK4TEMP DegC"
	;;

	fan)
		FAN=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.4.1.3.1 |  sed 's/.*ING: "//g' | sed 's/"//g'`
		
		if [ $FAN == "ok" ]; then
		  intReturn=$STATE_OK
		else
		  intReturn=$STATE_WARNING
		fi	
		outMessage="Fan: $FAN"
	;;
	
    cputemp)
		CPUTEMP=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.5.1.2.1 | awk '{print $4}'`
		CPUMAXTEMP=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.5.1.5.1 | awk '{print $4}'`
		CPUWARNTEMP=`expr $CPUMAXTEMP \* 85 / 100`
		
		if test "$CPUTEMP" -ge "$CPUMAXTEMP"; then
			intReturn=$STATE_CRITICAL
		elif test "$CPUTEMP" -ge "$CPUWARNTEMP"; then
			intReturn=$STATE_WARNING
		else
			intReturn=$STATE_OK
		fi
		outMessage="CPU Temperature: $CPUTEMP DegC"
	;;


	raidstatus)
		RAID=` snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.7.1.3.1 | awk '{print $4}'`
		RAIDSTAT=`snmpget $1 -v2c -c $2 .1.3.6.1.4.1.4526.22.7.1.4.1 | sed 's/.*ING: "//g' | sed 's/"//g'`

		if [ $RAIDSTAT == "REDUNDANT" ]; then
		  intReturn=$STATE_OK
		else
		  intReturn=$STATE_CRITICAL
		fi	
		outMessage="RAID: $RAID - $RAIDSTAT"
	;;

	*)
		intReturn=$STATE_UNKNOWN
		outMessage="  Usage: $0 <IP ADDRESS> <SNMP COMMUNITY> <CHECK> \n\n  Checks: \n  disk1status|disk2status|disk3status|disk4status \n  disk1temp|disk2temp|disk3temp|disk4temp \n  fan \n  cputemp \n  raidstatus"

	;;
esac

echo -e $outMessage
exit $intReturn
