#!/bin/bash
#target="http://jgamblin.com"
target="http://hsck.org"

echo
echo -e "Curling $target to test WAF detection"
echo 

while true
do 
UserAgent=`shuf -n 1 ua.txt`
	STARTTIME=$(date +%s)
	for run in {1..10}
	do 
	#curl -L --compressed -A "$UserAgent" -sL -w "%{http_code} %{url_effective}\\n" $target -o /dev/null
	curl -L --compressed -A "$UserAgent" -L  $target 
	done
	ENDTIME=$(date +%s)
	echo 
	echo -e "It took $(($ENDTIME - $STARTTIME)) seconds to complete 10 curls using:"
	echo -e "$UserAgent"
	echo
done
