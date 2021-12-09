#!/usr/bin/env python3

# https://gist.github.com/SidharthArya/f4d80c246793eb61be0ae928c9184406#gistcomment-3134474

import sys
import json
import subprocess

direction=bool(sys.argv[1] == 'next')
swaymsg = subprocess.run(['swaymsg', '-t', 'get_tree'], stdout=subprocess.PIPE)
data = json.loads(swaymsg.stdout)
current = data["nodes"][1]["current_workspace"]

for i in range(len(data["nodes"][1]["nodes"])):
    if data["nodes"][1]["nodes"][i]["name"] == current :
        workspace = i
        break

roi = data["nodes"][1]["nodes"][workspace]
temp = roi
windows = list()

def getNextWindow():

    if focus < len(windows) - 1:
        return focus+1
    else:
        return 0

def getPrevWindow():

    if focus > 0:
        return focus-1
    else:
        return len(windows)-1

def makelist(temp):

    for i in range(len(temp["nodes"])):
        if temp["nodes"][i]["name"] is None:
           makelist(temp["nodes"][i])
        else:
           windows.append(temp["nodes"][i])

def focused(temp_win):

    for i in range(len(temp_win)):
        if temp_win[i]["focused"] == True:
           return i

    return 9;

makelist(temp)
focus = focused(windows)

if direction:
    attr = "[con_id="+str(windows[getNextWindow()]["id"])+"]"
else:
    attr = "[con_id="+str(windows[getPrevWindow()]["id"])+"]"

sway = subprocess.run(['swaymsg', attr, 'focus'])
sys.exit(sway.returncode)
