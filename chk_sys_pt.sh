#!/bin/sh

#比对pos文件

fdate=`date +%Y%m%d`
#fdate="20141121"

NEW_POS1='Z:\data\WindDB\production\position\auto\'$fdate'.pos.csv'
OLD_POS1='Z:\data\WindDB\production\position\'$fdate'.pos.csv'
NEW_POS2='Z:\data\WindDB\production2\position\auto\'$fdate'.pos.csv'
OLD_POS2='Z:\data\WindDB\production2\position\'$fdate'.pos.csv'

NEW_TRADE1='Z:\data\WindDB\production\trade\auto\'$fdate'.trade.csv'
OLD_TRADE1='Z:\data\WindDB\production\trade\'$fdate'.trade.csv'
NEW_TRADE2='Z:\data\WindDB\production2\trade\auto\'$fdate'.trade.csv'
OLD_TRADE2='Z:\data\WindDB\production2\trade\'$fdate'.trade.csv'

echo "------Run production 1 pos new and old------"

awk -F ',' '
	BEGIN{ret=0;c1=0;c2=0}
	NR==FNR&&FNR>2{
		c1=c1+1;
		shr[$1]=$2
	}
	NR>FNR&&FNR>2{
		c2++;
		if(shr[$1]-$2!=0)		
		{
			ret=1
			printf("tk:%s shr:%s\n",$1,shr[$1])
		}
	}
	END{
		if(ret==1)
		{
			print "some value is different!check it please!"
		}
		if(c2!=c1)
		{
			print "the size is different"	
			printf("size of pos_old=%d,pos_new=%d\n",c1,c2);
		}
		else
		{
			printf("size of pos_old=%d,pos_new=%d\n",c1,c2);
			print "all the pos date is the same"
		}

	}
	' $NEW_POS1 $OLD_POS1

echo "------Run production 2 pos new and old----"
awk -F ',' '
	BEGIN{ret=0;c1=0;c2=0}
	NR==FNR&&FNR>2{
		c1=c1+1;
		shr[$1]=$2
	}
	NR>FNR&&FNR>2{
		c2++;
		if(shr[$1]-$2!=0)		
		{
			ret=1
			printf("tk:%s shr:%s\n",$1,shr[$1])
		}
	}
	END{
		if(ret==1)
		{
			print "some value is different!check it please!"
		}
		if(c2!=c1)
		{
			print "the size is different"	
			printf("size of pos_old=%d,pos_new=%d\n",c1,c2);
		}
		else
		{
			printf("size of pos_old=%d,pos_new=%d\n",c1,c2);
			print "all the pos data is the same"
		}

	}
	' $NEW_POS2 $OLD_POS2


echo "-----Run production 1 trade new and old-----"
awk -F ',' '
	BEGIN{ret=0;c1=0;c2=0}
	NR==FNR&&FNR>2{
		c1=c1+1;
		shr[$1]=$2
		tpx[$1]=$3
	}
	NR>FNR&&FNR>2{
		c2++;
		if(shr[$1]-$2!=0)		
		{
			ret=1
			printf("tk:%s shr:%s\n",$1,shr[$1])
		}
		if(tpx[$1]-$3!=0)		
		{
			ret=1
			printf("tk:%s shr:%d tpx:%d\n",$1,shr[$1]-$2,tpx[$1]-$3)
		}
	}
	END{
		if(ret==1)
		{
			print "some value is different!check it please!"
		}
		if(c2!=c1)
		{
			print "the size is different"
			printf("size of trade_old=%d,trade_new=%d\n",c1,c2);
		}
		else
		{
			printf("size of trade_old=%d,trade_new=%d\n",c1,c2);
			print "all the trade data is the same"
		}

	}
	' $NEW_TRADE1 $OLD_TRADE1
	
echo "-----Run production 2 trade new and old-----"
awk -F ',' '
	BEGIN{ret=0;c1=0;c2=0}
	NR==FNR&&FNR>2{
		c1=c1+1;
		shr[$1]=$2
		tpx[$1]=$3
	}
	NR>FNR&&FNR>2{
		c2++;
		if(shr[$1]-$2!=0)		
		{
			ret=1;
			printf("tk:%s shr:%s\n",$1,shr[$1]-$2)
		}
		if(tpx[$1]-$3!=0)		
		{
			ret=1;
			printf("tk:%s shr:%d tpx:%d\n",$1,shr[$1]-$2,tpx[$1]-$3)
		}
	}
	END{
		if(ret==1)
		{
			print "some value is different!check it please!"
		}
		if(c2!=c1)
		{
			print "the size is different"
			printf("size of trade_old=%d,trade_new=%d\n",c1,c2);
		}
		else
		{
			printf("size of trade_old=%d,trade_new=%d\n",c1,c2);
			print "all the trade data is the same"
		}

	}
	' $NEW_TRADE2 $OLD_TRADE2
	
