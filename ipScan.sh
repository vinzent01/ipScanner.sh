#!/bin/bash
createSaveFile () {
	if [ -f ./ipsFound.txt ]; then
		rm ipsFound.txt
	fi

	touch ipsFound.txt
}

findIp () {
	found=$(ping -c 1 $1 -t 100 | grep "64 bytes" | cut -d " " -f 4 | tr -d ":" )
	
	
	if ! [ -z $found ]; then
		save $found
	fi
}

save () {
	echo "Found IP: $1"
	echo $1 >> ipsFound.txt
}

createSaveFile

for sequence in `seq 1 254`; do 
	ip="192.168.0.$sequence"
	(findIp $ip &)
done
