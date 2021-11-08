#!/bin/bash
now="$(date)"
printf "Current date and time %s\n" "$now"
now="$(date +'%d%m%Y')"
printf "Current date in ddmmyyyy format %s\n" "$now"
echo "Starting backup at $now, please wait..."
#Make sure to replace the variables:
API_KEY=
CHAT_ID=
start=$(date '+%d/%m/%Y %H:%M:%S');
curl -s "https://api.telegram.org/bot$API_KEY/sendMessage?chat_id=$CHAT_ID&text=Backup Started at $start"
#mkdir /mnt/BackupDIR
mount -t cifs -o username=Jarvis,password=ftWWj6D8Lk5nKQxw,vers=2.0 //ip/BackupDIR/ /mnt/BackupDIR
dd bs=4M if=/dev/mmcblk0 | gzip -c >/mnt/BackupDIR/Jarvis-Pi-$now.img.gz
umount /mnt/BackupDIR
#rm /mnt/MtHDD
end=$(date '+%d/%m/%Y %H:%M:%S');
runtime=$((end-start))
curl -s "https://api.telegram.org/bot$API_KEY/sendMessage?chat_id=$CHAT_ID&text=Backup Finished at $end"
