file="video.log"
tail -5 $file
grep "ERROR" $file
grep "INFO: Начал обработку" $file | wc -l
grep "WARN" $file
grep "Завершено" $file | awk '{print $5}'
if grep 'ERROR.*video2.mp4' $file;then
	echo No
else 
	echo Yes
fi

grep "Завершено" $file | wc -l >> report.txt
grep "ERROR" $file | wc -l >> report.txt
echo "list:" >> report.txt
grep "Завершено" $file | awk '{print $5}' >> report.txt


