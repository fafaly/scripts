#!/bin/sh

if [ "$1" = "" ];then
	fdate=`date +%Y%m%d`
	ldate=`date -d '-1 day' +%Y%m%d`
else
	fdate=$1
	ldate=`date -d "$fdate -1 day" +%Y%m%d`
fi
echo 'the date is '$fdate,$ldate

trade_dir='/z/data/WindDB/production/trade/'$fdate'.trade.csv'
lastpos_dir='/z/data/WindDB/production/position/'$ldate'.pos.csv'
pos_dir='/z/data/WindDB/production/position/'$fdate'.pos.csv'
new_pos='/z/data/WindDB/production/position/posplus/'$fdate'.posplus.csv'


awk -F ',' -v OFS=',' '
	BEGIN{
		print "#tk,shr"
	}
	NR==FNR&&FNR>1{
		trade[$1]=$1;
		shr[$1]=$2
	}
	NR>FNR&&FNR>2{
		print $1,
		$2+shr[$1]
	}
	' $trade_dir $lastpos_dir > $new_pos

awk -F ',' -v OFS=',' '
	NR==FNR&&FNR>2{
		trade[$1]=$1;
		shr[$1]=$2
	}
	NR>FNR&&FNR>1&&trade[$1]{
		print $1,
		$2-shr[$1]
	}
	' $new_pos $pos_dir
	
