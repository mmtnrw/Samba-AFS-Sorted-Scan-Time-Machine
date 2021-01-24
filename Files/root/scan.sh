#!/bin/sh
HEUTE=`date +%Y%m%d`
GESTERN=`date -d '-1 day' '+%Y%m%d'`

mkdir /scan/${HEUTE} &> /dev/null
#mv /scan/${GESTERN}/* /scan/${HEUTE} &> /dev/null
rm /scan/heute
ln -s /scan/${HEUTE} /scan/heute
chmod 777 -R /scan
