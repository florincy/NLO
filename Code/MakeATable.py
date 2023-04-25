import subprocess
import os
import numpy as np
import csv
proc = subprocess.run(["./GetShielding2.0.sh"],
                      shell=True, capture_output=True)

res = proc.stdout
res = str(res)
print(res)
sres = res.split("\\n")
sres = sres[1:-1]
sres = [i.replace('isotropic =', '') for i in sres]
title = ['Método', "Blindagem"]
n = int((len(sres))/2)
print(n)
sres = np.array(sres)
met = np.split(sres, n)
for array in met:
    for i, row in enumerate(array):
        for j, value in enumerate(row):
            try:
              s = float(row)
              #print(s)
            except Exception:
              print("lala")
              #pass # do job to handle: Exception occurred while converting to int
            #print(row.isdecimal())
            print(row)
with open('blindagem.csv', 'w') as f:
    # using csv.writer method from CSV package
    write = csv.writer(f)
      
    write.writerow(title)
    write.writerows(met)
