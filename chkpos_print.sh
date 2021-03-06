#/bin/sh

if [ "$1" = "" -o "$2" = "" ];then
	echo "Usage:prog [date] [production number]"
	exit 0
fi

fdate=$1
appdir=/cygdrive/z/data/WindDB/production/app
ldate=`bash $appdir/tdlist.sh $fdate -1`
#ldate=`date -d "$fdate -1 day" +%Y%m%d`
echo 'the date is '$fdate,'the last date is '$ldate

if [ $2 -eq "1" ];then
	prog=production
elif [ $2 -eq "2" ];then
	prog=production$2
else
	echo "please input the right production number"
	exit 0
fi

trade_dir='/z/data/WindDB/'$prog'/trade/'$fdate'.trade.csv'
lastpos_dir='/z/data/WindDB/'$prog'/position/'$ldate'.pos.csv'
pos_dir='/z/data/WindDB/'$prog'/position/'$fdate'.pos.csv'
new_pos='/z/data/WindDB/'$prog'/position/'$fdate'.posplus.csv'


awk -F ',' -v OFS=',' '
	BEGIN{
		print "#tk,shr"
	}
	NR==FNR&&FNR>1{
		shr[$1]=$2
	}
	NR>FNR&&FNR>2{
		print $1,$2+shr[$1]
	}
	' $trade_dir $lastpos_dir > $new_pos

awk -F ',' -v OFS=',' '
	NR==FNR&&FNR>1{
		trade[$1]=$1
	}
	NR>FNR&&FNR>1&&!trade[$1]{
		print $1,$2
	}
' $new_pos $trade_dir >> $new_pos

awk -F ',' -v OFS=',' '
	BEGIN{ret=0}
	NR==FNR&&FNR>2{
		trade[$1]=$1;
		shr[$1]=$2
	}
	NR>FNR&&FNR>1&&trade[$1]{
		cmpret=$2-shr[$1]
		print $1,$2-shr[$1]
		if(cmpret!=0)
			ret=1;
	}
	END{
		if(ret==0)
			print "check finish!The pos file is correct!"
		else
			print "some value is different. Check it mannualy please"
	}
	' $pos_dir $new_pos 

rm -f $new_pos
