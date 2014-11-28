#!/bin/sh

fdate=`date +%YYmmdd`
fdate=$1
IPX_DIR=""
fname=$IPX_DIR$fdate'.ipx.csv'

echo -----------ipx file checking-----------
echo filename:$fname

awk -F ',' '
	BEGIN{count=0}
	{tk=$1;for(i=2;i<NF;i+=2)if($i==0)print tk,count++;}
	END{
		printf("numbers of wrong price:%d\nstock number:%d\n",count,NR)
		if(NR>2500&&NR<2600&&count==0)
			print "The ipx file is correct!"
		else
			print "some value is wrong please create the file again"
		}
	' $fname



