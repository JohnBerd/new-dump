#!/usr/bin/python3

import os
from shutil import copy
from pathlib import Path

ARDUINO_DIR         = '/usr/local/bin/arduino-1.8.9'
ARDUINO_LIBRARIES   = ARDUINO_DIR + '/libraries'
ARDUINO_BASE_LIBRARIES = ARDUINO_DIR + '/hardware/arduino/avr/cores/arduino'
LOCAL_PATH          = home = str(Path.home()) + '/Arduino'
PATH                = LOCAL_PATH + '/include'

def MyCopy(p):
    for subdir, dirs, files in os.walk(p):
        for file in files:
            filepath = subdir + os.sep + file
            if filepath.endswith(".h"):
                copy(filepath, PATH)
os.mkdir(PATH)
MyCopy(ARDUINO_BASE_LIBRARIES)
MyCopy(ARDUINO_LIBRARIES)
