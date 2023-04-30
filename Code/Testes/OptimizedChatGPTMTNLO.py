import sys
import subprocess
import pandas as pd
import os
import numpy as np
import csv
import re
import math
import pathlib

def calculate_root(prop_values):
    return math.sqrt(sum(prop_values))

def search_and_create(keywords, writer, reader):
    prop_values = [[False, False, False], [False, False, False]]

    for i, row in enumerate(reader):
        row = [x.strip() for x in row]

        # Check for Tot prop columns
        for j, prop_value in enumerate(prop_values):
            if prop_value[2]:
                prop_value[2] = (float(row[3]) / 3) ** 2
                tot_prop = calculate_root(prop_value)
                writer.writerow(["Tot prop", tot_prop])
                prop_value[2] = False

            if prop_value[1]:
                prop_value[1] = (float(row[3]) / 3) ** 2
                prop_value[2] = True
                prop_value[0] = False

            if prop_value[0]:
                prop_value[0] = (float(row[3]) / 3) ** 2
                prop_value[1] = True
                prop_value[2] = False

        # Check for keywords
        for j, keyword in enumerate(keywords):
            if keyword in row[0]:
                prop_values[j][0] = True
                prop_values[1-j][0] = False

        writer.writerow(list(row))

    writer.writerow(["End of report"])

ResultsPath = sys.argv[1]
print(ResultsPath)

title = ['Campos e metodos', 'tensor', 'au','esu', 'outra']
readFile=pd.read_csv(ResultsPath, error_bad_lines=False, header=None, delimiter=":", usecols=[0, 1, 2, 3])
readFile.to_csv('Results.csv', index = None)
with open('Results.csv') as inf, open('Results2.csv', 'w') as ouf:
    reader = csv.reader(inf)
    writer = csv.writer(ouf)
    dw = csv.DictWriter(ouf, delimiter=',', 
                        fieldnames=title)
    dw.writeheader()
    keywords=["Beta(-2w,w,w)","Beta(-w,w,0)"]
    search_and_create(keywords, writer, reader)
