if [ $# -ne 2 ]; then
    echo "use: $0 <catalog> <catalog for backup>"
    exit
fi
time=$(date +%Y%m%d_%H%M)
echo "Backup running $time"
echo "catalog: $1"
tar -czvf "$2/backup_$time.tar.gz" "$1"

