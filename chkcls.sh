#./bin/sh

dpx_dir='/z/data/WindTerminal/dpx/'
netvalue_dir='/z/data/WindDB/production/NetValue/'
fdate=$1
fnetv=$netvalue_dir$fdate'.csv'
fdpx=$dpx_dir$fdate'.dpx.csv'

awk -F ',' '
	BEGIN{
		ret=0
	}
	NR==FNR&&FNR>1{
		tk=substr($1,1,6);
		cls[tk]=$7
	}
	NR>FNR&&FNR>15{
		tk=substr($1,10,6);
		code=substr($1,10,2);
		if(code=="00"||code=="30"||code=="60")
			px=substr($7,2,length($7)-2);
			if((cls[px]-$7)!=0)
					ret=-1
	}
	END{
		if(ret==0)
			print "All the data is correct!"
		else
			print "Some data is not correct,please check!"
	}
	' $fdpx $fnetv
