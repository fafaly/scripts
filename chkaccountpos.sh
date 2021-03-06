#/bin/sh

fdate=$1
pos_dir='Z:\data\WindDB\production\position\'
zx_account_dir='Z:\data\WindDB\production\Citics_dailyDetails\'
posname=$pos_dir$fdate'.pos.csv'
accname=$zx_account_dir$fdate'.zx_account.csv'

echo '-------- check cash of account and pos ----------'
echo '[INFO] '$posname
echo '[INFO] '$accname

awk -F ',' 'BEGIN{bg=0;ed=0;count1=0;count2=0;ret=0}
			NR==FNR&&substr($1,2,2)=="合计"{ed++}
			NR==FNR&&bg==1&&ed==1{tk=substr($2,2,6);shr[tk]=substr($4,2,length($4)-2);count1++}
			FNR>2&&NR>FNR{
					if(shr[$1]-$2!=0)
					{
							ret=1;
							print $1,shr[$1],$2
					}
					count2++;
			}
			{a=substr($1,2,4); if(a=="股东帐号")bg=1;}
			END{
			printf("[INFO] The rows of account pos:%d,our position.csv :% d\n",count1,count2)
			if(ret==0){print "[INFO] The accounts position data is the same as the position.csv"} else{ print "[WARN] Some value is different please check"}
			print ""}
			' $accname $posname
