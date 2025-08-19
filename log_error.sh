#!/bin/bash
logfile="/var/log/nginx/access.log"

echo "🔍 Ошибки 4xx и 5xx:"
grep -E ' " (4|5)[0-9][0-9] ' "$logfile" | head -20
