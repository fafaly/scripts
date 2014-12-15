#!/bin/sh

fdate=$1

trade_sys_dir='Z:\data\WindDB\production\trade\auto\'
trd_account_dir='Z:\data\WindDB\production\Citics_dailyDetails\trd_account\'
accname=$trd_account_dir$fdate'.trd_account.csv'
tname=$trade_sys_dir$fdate'.trade.csv'

echo "-------------checking TradingSystem and account --------"
echo "[INFO] filename:"$tname
echo "[INFO] filename:"$accname

awk -F ',' 'BEGIN{ret=0;}
			NR==FNR&&FNR>1{
				tk=$1;
				atcash[tk]=$5;
			}
			NR>FNR&&FNR>1{
				mycash=$2*$3;
				if(mycash<0)
					mycash = -mycash;
				acash=sprintf("%d",atcash[$1]);
				mycash=sprintf("%d",mycash);
				if(mycash-acash>1)
				{
					ret=1;
					printf("[WARN] stock num:%s,account cash:%d,tradesys cash:%d\n",$1,acash,mycash);
				}
			}
			END{
				if(ret==0)
					print "[INFO] Each stock_s happen cash is the same."
				else
					print "[WARN] Some value is wrong please check!"
			}	
			' $accname $tname
