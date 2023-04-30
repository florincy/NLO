import subprocess
import pandas as pd
import os
import numpy as np
import csv
import re
import math
import pathlib
def searchAndCreate(keyword1,keyword2):
    root=[0.0, 0.0]
    p=np.array([[False, False, False] ,[False, False, False]], dtype=bool)
    pv=[[0.0, 0.0, 0.0], [0.0, 0.0, 0.0]]
    AddTot=[False, False]
    for row in inf:
        col=["Tot prop"] 
        col2=["Tot prop"] 
        row= row.split("   ")
        row = [x for x in row if x != '']
        row = [x.strip() for x in row if x]
        if p[0][2]==True:
            pv[0][2]=((float(row[3].replace('D','E')))/3)**2
            root[0]=root[0]+pv[0][2]
            root[0] = math.sqrt(root[0])
            col.append(root[0])
            root[0]=0
            AddTot[0]=True
        elif p[1][2]==True:
            pv[1][2]=((float(row[3].replace('D','E')))/3)**2
            root[1]=root[1]+pv[1][2]
            root[1] = math.sqrt(root[1])
            col2.append(root[1])
            root[1]=0
            AddTot[1]=True
        else:
            AddTot[1]=False
            AddTot[0]=False
        if p[0][1]==True:
            pv[0][1]=((float(row[3].replace('D','E')))/3)**2
            p[0][2]=True
            root[0]=root[0]+pv[0][1]
        elif p[1][1]==True:
            pv[1][1]=((float(row[3].replace('D','E')))/3)**2
            p[1][2]=True
            root[1]=root[1]+pv[1][1]
        else:
            p[0][2]=False
            p[1][2]=False
        if p[0][0] == True:
            pv[0][0]=((float(row[3].replace('D','E')))/3)**2
            p[0][1]=True
            root[0]=root[0]+pv[0][0]
        elif p[1][0] == True:
            pv[1][0]=((float(row[3].replace('D','E')))/3)**2
            p[1][1]=True
            root[1]=root[1]+pv[1][0]
        else:
            p[0][1]=False
            p[1][1]=False 
        for i in row:
            if keyword1 in i:
                p[0][0]=True
                root[0]=0
            elif keyword2 in i:
                p[1][0]=True
                root[1]=0      
            else:
                p[0][0]=False
                p[1][0]=False
        writer.writerows([row])
        if AddTot[0]==True:
            writer.writerows([col])
        if AddTot[1]==True:
            writer.writerows([col2])
proc = subprocess.run(["./GetNLO.sh"],
                      shell=True, stdout=subprocess.PIPE, universal_newlines=True )
res = proc.stdout
res = str(res)
res = res[3:-1]
res = res.replace("home", "//home")
print(res)
title = ['Campos e metodos', 'tensor', 'au','esu', 'outra']
readFile=pd.read_csv(res, error_bad_lines=False, header=None, delimiter=":")
readFile.to_csv('Results.csv', index = None)
with open('Results.csv') as inf, open('Results2.csv', 'w') as ouf:
    reader = csv.reader(inf)
    writer = csv.writer(ouf)
    dw = csv.DictWriter(ouf, delimiter=',', 
                        fieldnames=title)
    dw.writeheader()
    searchAndCreate("Beta(-2w,w,w)", "Beta(-w,w,0)")
    ouf.close()


    


