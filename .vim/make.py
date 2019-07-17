#!/usr/bin/python3

import glob
import os
import subprocess

cwd = os.getcwd()


def getExec(cwd, x):
    for filename in os.listdir(cwd):
        if os.path.isfile(cwd + "/" + filename) and os.access(cwd + "/" + filename, os.X_OK):
            print (filename)
            subprocess.run([("../" * x) + filename])


for x in range(0, 3):
    if glob.glob(cwd+"/Makefile").__len__() == 1:
        subprocess.run(["make", "-C", "." + ("/.." * x)])
        getExec(cwd, x)
        exit
    cwd = os.path.abspath(os.path.join(cwd, os.pardir))
