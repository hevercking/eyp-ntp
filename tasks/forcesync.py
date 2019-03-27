#!/usr/bin/python

import sys
import json
from pprint import pprint
import subprocess

params = json.load(sys.stdin)

ntpserver = params['ntpserver']

result={}
result['forcesync']={}
result['forcesync']['server']=ntpserver
result['forcesync']['output']=subprocess.check_output("ntpdate "+ntpserver, shell=True)

print(json.dumps(result))
