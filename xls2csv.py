#!/usr/bin/python

import glob
import os
import time
import win32com.client

xlsx_files = glob.glob('*.xlsx')

if len(xlsx_files) == 0:
    raise RuntimeError('No XLSX Files')
xlApp = win32com.client.Dispatch('Excel.Application')

for file in xlsx_files:
    xlWb = xlApp.Workbooks.Open(os.path.join(os.getcwd(),file))
    xlWb.SaveAs(os.path.join(os.getcwd(), file.split('.xlsx')[0] +'.csv'), FileFormat=6)

xlApp.Quit()
time.sleep(2)
