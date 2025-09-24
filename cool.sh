for i in google.com pornhub.com youtube.com lol.com;do
	if ping -c 1 $i > /dev/null;then
		echo $i is up
	else 
		echo $i is down
	fi
done

