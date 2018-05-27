#!/bin/bash
. /var/www/html/openWB/openwb.conf

if [[ $sdm630modbusllsource = *virtual* ]]
then
	if ps ax |grep -v grep |grep "socat pty,link=$sdm630modbusllsource,raw tcp:$sdm630modbuslllanip:26" > /dev/null
	then
		echo "test" > /dev/null
	else
		sudo socat pty,link=$sdm630modbusllsource,raw tcp:$sdm630modbuslllanip:26 &
	fi
else
	echo "echo" > /dev/null
fi
n=0
output=$(sudo python /var/www/html/openWB/modules/sdm630modbusll/readsdm.py $sdm630modbusllsource $sdm630modbusllid)
while read -r line; do
	if (( $n == 0 )); then
		lla1=$(echo "$line" |  cut -c2- )
		lla1=${lla1%??}
		printf "%.1f\n" $lla1 > /var/www/html/openWB/ramdisk/lla1
	fi
	if (( $n == 1 )); then
		lla2=$(echo "$line" |  cut -c2- )
		lla2=${lla2%??}
		printf "%.1f\n" $lla2 > /var/www/html/openWB/ramdisk/lla2
	fi
	if (( $n == 2 )); then
		lla3=$(echo "$line" |  cut -c2- )
		lla3=${lla3%??}
		printf "%.1f\n" $lla3 > /var/www/html/openWB/ramdisk/lla3
	fi
if (( $n == 3 )); then
	wl1=$(echo "$line" |  cut -c2- |sed 's/\..*$//')
fi
if (( $n == 4 )); then
	llkwh=$(echo "$line" |  cut -c2- )
       echo ${llkwh%??} > /var/www/html/openWB/ramdisk/llkwh
fi
if (( $n == 5 )); then
	wl2=$(echo "$line" |  cut -c2- |sed 's/\..*$//')
fi
if (( $n == 6 )); then
	wl3=$(echo "$line" |  cut -c2- |sed 's/\..*$//')
fi
if (( $n == 7 )); then
llv1=$(echo "$line" |  cut -c2- )
llv1=${llv1%??}
printf "%.1f\n" $llv1 > /var/www/html/openWB/ramdisk/llv1
fi
if (( $n == 8 )); then
llv2=$(echo "$line" |  cut -c2- )
llv2=${llv2%??}
printf "%.1f\n" $llv2 > /var/www/html/openWB/ramdisk/llv2
fi
if (( $n == 9 )); then
llv3=$(echo "$line" |  cut -c2- )
llv3=${llv3%??}
printf "%.1f\n" $llv3 > /var/www/html/openWB/ramdisk/llv3
fi
if (( $n == 10 )); then
echo "$line" |  cut -c2- |sed 's/\..*$//' > /var/www/html/openWB/ramdisk/llaltnv
llaltnv=$(echo "$line" |  cut -c2- )
llaltnv=${llaltnv%??}
printf "%.1f\n" $llaltnv > /var/www/html/openWB/ramdisk/llaltnv
fi
if (( $n == 11 )); then
	llhz=$(echo "$line" |  cut -c2- )
	llhz=${llhz%??} 
        printf "%.1f\n" $llhz > /var/www/html/openWB/ramdisk/llhz
fi
if (( $n == 12 )); then
echo "$line" |  cut -c2- |sed 's/\..*$//' > /var/www/html/openWB/ramdisk/llpf1
fi
if (( $n == 13 )); then
echo "$line" |  cut -c2- |sed 's/\..*$//' > /var/www/html/openWB/ramdisk/llpf2
fi
if (( $n == 14 )); then
echo "$line" |  cut -c2- |sed 's/\..*$//' > /var/www/html/openWB/ramdisk/llpf3
fi








	
	n=$((n + 1))
    done <<< "$output"


llaktuell=`echo "($wl1+$wl2+$wl3)" |bc`
echo $llaktuell > /var/www/html/openWB/ramdisk/llaktuell
											
