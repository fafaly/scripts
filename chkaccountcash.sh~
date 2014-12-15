#!/bin/sh

fdate=$1

zx_account_dir='Z:\data\WindDB\production\Citics_dailyDetails\'
accname=$zx_account_dir$fdate'.zx_account.csv'

echo -e "----------check account total asset--------------"
echo -e '[INFO] '$accname

awk -F ',' 'BEGIN{ret=0;st=0;ed=0;amt=0;assetindex=0}
			assetindex==1{rest=substr($3,2,length($3)-2);asset=substr($6,2,length($6)-2);assetindex++}
			substr($1,2,4)=="客户代码"{assetindex++}
			substr($1,2,2)=="合计"{ed++}
			st==1&&ed==1{
				shr=substr($4,2,length($4)-2);
				cls=substr($8,2,length($8)-2);
				amt+=1.0*cls*shr;
			}
			{a=substr($1,2,4); if(a=="股东帐号")st=1;};
			END{
				ourasset=amt+rest;
				ourasset=sprintf("%.3f",ourasset);
				asset=sprintf("%.3f",asset);
				printf("[INFO] share total cash:%f,rest asset:%f,our asset:%f\n[INFO] account_s total asset:%f\n",amt,rest,ourasset,asset);
				if(ourasset==asset){
					print "[INFO] The total asset is correct"
				}
				else{
					print "[WARN] amt + rest != asset.Please check"
				}
				
			} 

' $accname
