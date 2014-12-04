#!/bin/sh

fdate=$1
zx_account_dir=''
accname=$zx_account_dir$fdate'.zx_account.csv'
netvalue_dir=''
nvname=$netvalue_dir$fdate'.NetValue.csv'

echo ------------check netvalue and account---------------
echo "[INFO] filename:"$accname
echo "[INFO] filename:"$nvname

awk -F ',' 'BEGIN{bg=0;ed=0;count1=0;count2=0;ret=0}
			NR==FNR&&substr($1,2,2)=="合计"{ed++}
			NR==FNR&&bg==1&&ed==1{tk=substr($2,2,6);cash[tk]=substr($9,2,length($9)-2);count1++}
			{a=substr($1,2,4); if(a=="股东帐号")bg=1;};

			NR>FNR&&substr($1,2,4)=="1102"&&length($1)==16{
				c2=substr($8,2,length($8)-2);
				tk=substr($1,10,6);
				count2++;
				if(cash[tk]-c2!=0)
				{
					print "[WARN]",cash[tk],c2;
					ret=1;
				}
			}
			END{
			printf("[INFO] The nmuber of stock in account:%d,in NetValue.csv :% d\n",count1,count2)
			if(ret==0){print "[INFO] The reference value of account and Netvalue file is the same"} else{ print "[WARN] Some value is different please check"}}
			' $accname $nvname
