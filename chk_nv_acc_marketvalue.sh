#/bin/sh
netvalue_dir='/z/data/WindDB/production/NetValue/'
details_dir='/z/data/WindDB/production/Citics_dailyDetails/'
fdate=$1
fnetv=$netvalue_dir$fdate'.NetValue.csv'
fdet=$details_dir$fdate'.zx_account.csv'
if [ ! -f $fnetv ];then
    f1=-1
fi
if [ ! -f $fdet ];then
    f2=-1
fi
if [[ $f1 -eq -1 ]] || [[ $f2 -eq -1 ]];then
    if [ $f1 -eq -1 ];then
        echo '[Error]:  '$fnetv' not exist!!!'
    fi
    if [ $f2 -eq -1 ];then
        echo '[Error]:  '$fdet' not exist!!!'
    fi
    exit
fi
echo '[INFO]:   '$fnetv
echo '[INFO]:   '$fdet



awk -F ',' '
    BEGIN{
        ret=-1;
    }
    NR==FNR&&FNR==9{
        str1=substr($8,2,length($8)-2);
    }
    NR>FNR && FNR==8{
        str2=substr($3,2,length($3)-2);
        if(str2-str1=="22660.1")
            ret=0;
    }
    END{
        if(ret==0)
            print "[INFO]:  maket_value and netvalue is the same!!!"
        else
            print "[Error]: maket_value and netvalue not the same!!!"
    }
    ' $fnetv $fdet

