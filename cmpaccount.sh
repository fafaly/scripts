#!/bin/sh

mydate=`date +%Y%m%d`
myaccdir='C:\Users\fafaly\Documents\Visual Studio 2013\Projects\FileCreator\FileCreator\our_account'

fdate=$1
itsaccfile=$fdate'.trd_account.csv'
myaccfile='Z:\data\WindDB\production\Citics_dailyDetails\our_account\'$fdate'.account.csv'
out_dir='Z:\data\WindDB\production\Citics_dailyDetails\cmpret\'
in_zx_dir='Z:\data\WindDB\production\Citics_dailyDetails\trd_account\'

if [ "$1" = "" ];then
	echo "please enter the date"
	exit 1
fi

awk -F ',' -v OFS=',' '
	BEGIN{
		print "#tk,trade,rest_shr,tpx,happen_cash,commission,stamp_tax,transfer,clearing"
	}
	NR==FNR&&NR>1{
		trade[$1]=$2;
		rshr[$1]=$3;
		tpx[$1]=$4;
		hcash[$1]=$5;
		comm[$1]=$6;
		stamp[$1]=$7;
		trans[$1]=$8;
		clear[$1]=$9
	}
	NR>FNR&&trade[$1]{
		print $1,
		trade[$1]-$2,
		rshr[$1]-$3,
		tpx[$1]-$4,
		hcash[$1]-$5,
		comm[$1]-$6,
		stamp[$1]-$7,
		trans[$1]-$8,
		clear[$1]=$9

	}
	' $in_zx_dir/$itsaccfile $myaccfile > $out_dir/$fdate'.acc_cmp_ret.csv'

	echo 'Excuted Successful!!'