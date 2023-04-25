import subprocess
import pandas as pd
import os
import numpy as np
import csv
import re
import math
import pathlib
proc = subprocess.run(["./GetNLO.sh"],
                      shell=True, stdout=subprocess.PIPE, universal_newlines=True )

res = proc.stdout
res = str(res)
res=res.rstrip()


'''
res = res[1:-1]
res = res.replace("\nhome", "home")
res = res.replace("/", "//")
res = res.replace("//home", "home")
'''
print(res)

title = ['Campos e metodos', 'tensor', 'au','esu', 'outra']
readFile=pd.read_csv(res, error_bad_lines=False, header=None, delimiter=":")

'''
readFile.to_csv('Results.csv', index = None)
with open('Results.csv') as inf, open('Results2.csv', 'w') as ouf:
    reader = csv.reader(inf)
    writer = csv.writer(ouf)
    dw = csv.DictWriter(ouf, delimiter=',', 
                        fieldnames=title)
    dw.writeheader()
    n=0
    x=False
    y=False
    z=False
    root=0
    for row in inf:
        col=["Tot prop"] 
        n=n+1
        row= row.split("   ")
        row = [x for x in row if x != '']
        row = [x.strip() for x in row if x]
        xv, yv, zv = 0.0, 0.0, 0.0 
        b1="Beta(-w,w,0)"
        if z==True:
            zv=((float(row[3].replace('D','E')))/3)**2
            root=root+zv
            root = math.sqrt(root)
            col.append(root)
            root=0
            AddTot=True
        else:
            AddTot=False
        if y==True:
            yv=((float(row[3].replace('D','E')))/3)**2
            z=True
            root=root+yv
        else:
            z=False
        if x==True:
            xv=((float(row[3].replace('D','E')))/3)**2
            y=True
            root=root+xv
        else:
            y=False
        for i in row:
            if b1 in i:
                x=True
                root=0
            else:
                x=False
        writer.writerows([row])
        if AddTot==True:
            writer.writerows([col])
    ouf.close()
'''

    


