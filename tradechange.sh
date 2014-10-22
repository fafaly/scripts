#!/bin/sh

#cat /z/data/WindDB/production/trade/20140903.trade.csv | awk -F ',' -v OFS=',' '{print $1,-1.0*$2,$3}' > testtrade.csv
filedir='/z/data/WindDB/production/trade/'
for eachfile in `ls -B $filedir*.trade.csv`
do
	fdate=${eachfile%.trade.csv}
	fdate=${fdate##*/}
	cat $filedir$fdate.trade.csv  | awk -F ',' -v OFS=',' 'NR==1{print $1,$2,$3} NR>1{print $1,-1.0*$2,$3}' > $fdate.trade.csv
done
