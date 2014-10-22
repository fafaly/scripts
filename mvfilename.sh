#!/bin/sh

#thie file use to remove the citic's account chinese word in the filename
output_dir='/z/data/WindDB/production/account/CITIC_account/'
for eachfile in `ls "/z/data/WindDB/production/account/CITIC_account/" -B`
do
		 filename=${eachfile%.xls}
		  filehead=`echo $filename | awk -F _ '{print $5 }'`
		    mv $output_dir$filename.xls $output_dir$filehead.xls
	done
