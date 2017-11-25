#!/bin/bash
sudo apt-get install curl
clear

#colors
green=`tput setaf 2`
reset=`tput sgr0`

echo "[x] ${green}FIND my URL${reset} [x]"
sleep 1
echo "[x] Installing dependencies..."
sleep 1
echo "[x] Preparing to analyze $1..."
sleep 2
echo "[x] Wait..."
echo

for word in $(cat wordlist.txt) #cat wordlist
	do
#find-directories
		requestdir=$(curl -s -o /dev/null -w "%{http_code}" $1/$word/) #curl-http-code
		if [ $requestdir == "200" ]
			then #available-request
				echo "I found: http://$1/${green}$word${reset}"
		fi
#find-files
		requestfile=$(curl -s -o /dev/null -w "%{http_code}" $1/$word) #curl-http-code
		if [ $requestfile == "200" ]
			then #available-request
				if [ "$requestfile" != "$requestdir" ] #if request 1 != request 2 then, required to differenciate files and directories
					then #not equal to
						echo "I found: http://$1/${green}$word${reset}"
				fi
		fi

#find-subdomain
		requestsub=$(curl -s -o /dev/null -w "%{http_code}" $word.$1) #curl-http-code
		if [ $requestsub == "200" ]
			then #available-request
				echo "I found: http://${green}$word${reset}.$1"
		fi
	done