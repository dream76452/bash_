#!/bin/bash
cpu_usage=$(top -bn1 |  grep 'Cpu(s)' | awk '{print $2}' | sed 's/%//')
max_cpu=75
if (( $(echo "$cpu_usage >= $max_cpu" | bc -l ) ));then
	echo This is bad 
	echo cpu now $cpu_usage %
else
	echo cpu is ok
	echo cpu now $cpu_usage %

fi
