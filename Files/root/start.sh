#!/bin/sh

echo "[info] Setting up Timezone : $TZ"
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone

echo "[info] Syncing Time...."
ntpd -d -q -n -p time.cloudflare.com &> /dev/null

echo "[info] Starting Cronie....."
/usr/sbin/crond &

echo "[info] Starting Date Sorted Folder Script...."
source /root/scan.sh

echo "[info] Updating Scan Folder...."
source /root/scan.sh

echo "[info] Starting SAMBA and AVAHI...."
/usr/sbin/nmbd -D
/usr/sbin/avahi-daemon -D
/usr/sbin/smbd -F


#if [[ ! -z "$LISTEN" ]]; then
#echo "[info] Changing Interface to: $LISTEN"
#sed -i "1,/interface/ s/interface: .*$/interface: $LISTEN/" /etc/unbound/unbound.conf
#fi
#echo "[info] Starting Unbound....."
#chown -R unbound:unbound /etc/unbound
#/usr/sbin/unbound -d -vvv
#echo "[info] Starting Bash for Error searching....."
#/bin/sh
