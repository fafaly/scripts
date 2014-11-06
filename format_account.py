#-*- coding: UTF-8 -*- 
import os
import shlex
import sys  
import csv
import re

fdate = "20140902"
filename = fdate + ".csv"
csvlist= []
out_dir = "zx_account//"
in_dir = "..//zxnature_account//"

def removecomma(str):
	while 1:
	    mm = re.search("\d,\d", str)
	    if mm:
	        mm = mm.group()
	        str = str.replace(mm, mm.replace(",", ""))
	    else:
      		break
	return str

def mklist(linestr):
	strtmp = shlex.shlex(linestr,posix=True)
	strtmp.whitespace = ','
	strtmp.whitespace_split = True
	return list(strtmp)

#去掉多余列
def getrealaccount():
	fp = open(filename,"r+")
	reader = csv.reader(fp)
	try:
		i=0
		tradeshr = 0.0
		for linelist in reader:
			if cmp(linelist[0],fdate) != 0:
				continue
			if cmp(linelist[0],'合计：') == 0:
				break
			else:
				if cmp(linelist[1],'证券卖出') == 0:
					tradeshr = -float(removecomma(linelist[5]))#由于原trade文件问题导致符号相反，这里的负号也相反
				elif cmp(linelist[1],'证券买入') ==0 :
					tradeshr = float(removecomma(linelist[5]))
				else:
					continue
				tmplist = [linelist[3],tradeshr, float(linelist[6]),float(linelist[7]),float(removecomma(linelist[8])),float(linelist[9]),float(linelist[10]),float(linelist[11]),float(linelist[12])]
				csvlist.append(tmplist)
			#fpnew.write(nstrline)
	except Exception, e:
		raise
	finally:
		fp.close()
		#fpnew.close()

#先转换格式为utf-8然后读取
def convert2utf8():
	utfFile=open(filename)
	tstr = utfFile.read()
	tstr = tstr.decode("gb18030")
	utfFile.close()
	utfFile = open(filename, 'w')
	utfFile.write(tstr)
	utfFile.close()

def pri(reader):
    for i in reader:
       print i

def mergeLine():
	#先排序
	csvlist.sort(lambda a,b:cmp(a[0],b[0]))
	#pri(csvlist)
	#遍历二维数组
	fpnew = open(out_dir+fdate+'.zx_account.csv',"w")
	lasttk = csvlist[0][0]
	mergelist = []
	mergelist.append(csvlist[0])
	count = 1 #记录相同的有多少个
	j =0
	fpnew.write("#tk,trade,rest_shr,tpx,happen_cash,commission,stamp_tax,transfer,clearing\n")
	for i in range(1,len(csvlist)):
		if cmp(csvlist[i][0],lasttk)==0:
			count = count + 1
			mergelist[j][1] = mergelist[j][1] + csvlist[i][1]
			mergelist[j][2] = csvlist[i][2]
			mergelist[j][3] = mergelist[j][3] + csvlist[i][3]
			mergelist[j][4] = mergelist[j][4] + csvlist[i][4]
			mergelist[j][5] = mergelist[j][5] + csvlist[i][5]
			mergelist[j][6] = mergelist[j][6] + csvlist[i][6]
			mergelist[j][7] = mergelist[j][7] + csvlist[i][7]
			mergelist[j][7] = mergelist[j][8] + csvlist[i][8]
		else:
			mergelist[j][3] = mergelist[j][3] /count
			#mergelist[j][5] = mergelist[j][5] /count
			#mergelist[j][6] = mergelist[j][6] /count
			#mergelist[j][7] = mergelist[j][7] /count
			#mergelist[j][8] = mergelist[j][8] /count
			fpnew.write("%s,%s,%s,%s,%s,%s,%s,%s,%s\n" % \
					(mergelist[j][0],mergelist[j][1], mergelist[j][2], \
						mergelist[j][3],mergelist[j][4],mergelist[j][5],mergelist[j][6],mergelist[j][7],mergelist[j][8]))
			mergelist.append(csvlist[i])
			j = j+1
			lasttk = csvlist[i][0]
			count = 1
	fpnew.write("%s,%s,%s,%s,%s,%s,%s,%s,%s\n" % \
					(mergelist[j][0],mergelist[j][1], mergelist[j][2], \
						mergelist[j][3],mergelist[j][4],mergelist[j][5],mergelist[j][6],mergelist[j][7],mergelist[j][8]))
	fpnew.close()
	#pri(mergelist)

if __name__ == '__main__':
	reload(sys)   
	sys.setdefaultencoding('utf8')  
	filename = in_dir + fdate + ".csv"
	convert2utf8()
	getrealaccount()
	mergeLine()
