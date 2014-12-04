#!/bin/sh

fdate=`date +%Y%m%d`
ldate=`date -d "$fdate -1 day" +"%Y%m%d"`
zx_acc_dir='Z:\data\WindDB\production\Citics_dailyDetails\'
log_dir=$zx_acc_dir'\log\'$fdate'.log.txt'
./chkipx.sh $ldate >> $log_dir
