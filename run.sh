#!/bin/bash
#coded by 0xbit

listen() {
	rm .link.log >> /dev/null 2>&1 
	
	if [[ `command -v termux-chroot` ]]; then
			sleep 2 && termux-chroot cloudflared tunnel -url 127.0.0.1:8080 --logfile .link.log > /dev/null 2>&1 &
	else
		sleep 2 && ./cloudflared tunnel -url 127.0.0.1:8080 --logfile .link.log > /dev/null 2>&1 &
	fi
	sleep 15
	
	cldflr_link=$(grep -o 'https://[-0-9a-z]*\.trycloudflare.com' ".link.log") 
	echo -e "\n[-] URL : $cldflr_link"
	}

listen
