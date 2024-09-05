#!/bin/bash
#IP_LIST=($(cat /g/ipdata.txt))
#echo $IP_LIST

#index=0
IP_LIST='a'
#while read line; do
#  $IP_LIST11[$index]=$line
#  index=$(expr $index + 1 )
#  echo a[$index]
#done < /g/ipdata.txt
#readarray -t IP_LIST < /g/ipdata.txt
#echo $IP_LIST
IP_LIST1="10.0.0.1 10.0.0.2 8.8.8.8 10.0.0.34"  #将ip放进数组中ping -c 1 $ip >/dev/null
#echo $IP_LIST1

#for ip in $IP_LIST; do 
while read ip; do
    echo $ip
    num=1    
    while [ $num -le 3 ]  
    do
        if ping -n 1 -w 1000 $ip >/dev/null
        then
           echo "$ip Ping is success"  
           break
        else
           FALL[$num]=$ip  	 		   
           let num++
        fi
    done
    if [ ${#FALL[*]} -eq 3 ]          
    then
        echo "${FALL[1]} Ping is failure!"
        unset FALL[*]
    fi

done < /g/ipdata.txt
   

done