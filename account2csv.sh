#!/bin/sh

fdate=$1
./xls2csv_xlrd.py  '账户对账单_每日_8100000150_高莹莹_'$fdate'.xls' $fdate'.zx_account.csv'
