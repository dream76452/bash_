usage=$(df / | grep '/dev' | awk '{print $5}' | sed 's/%//') #or replace(grep,tail -1)
edge_disk=80
if [ $usage -ge $edge_disk ];then
	echo Disk bad
	echo clean disk
else
	echo disk normal
	echo disk use $usage %
fi
