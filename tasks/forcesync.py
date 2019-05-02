#!/usr/bin/python

import sys
import json
from pprint import pprint
import subprocess

params = json.load(sys.stdin)

ntpserver = params['ntpserver']

# puppet resource service ntp ensure=stopped

result={}
result['forcesync']={}
result['forcesync']['server']=ntpserver
result['forcesync']['output']=subprocess.check_output("ntpdate "+ntpserver, shell=True)

# puppet resource service ntp ensure=running

print(json.dumps(result))
