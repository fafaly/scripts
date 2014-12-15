#!/usr/bin/env python
#-*- encoding: utf-8 -*-

import sys
import random

def test(para1,para2):
    path="20141215.order.csv"
    fp1=open(path,'w')
    for i in range(1,501):
        num=random.randint(1,100)
        ch=random.randint(1,2)
        if(ch==1):
            fp1.write(str(i)+","+str(num*100)+","+"B,"+str(para1)+","+str(para2)+"\n")
        else:
            fp1.write(str(i)+","+str(num*100)+","+"S,"+str(para1)+","+str(para2)+"\n")
    fp1.close()

if __name__=='__main__':
    if(len(sys.argv)==3):
        test(sys.argv[1],sys.argv[2])
    else:
        print 'parameter is wrong!!!'
            

    
