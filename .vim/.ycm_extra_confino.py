import os
from shutil import copy
from os.path import expanduser

ARDUINO_DIR         = '/usr/local/bin/arduino-1.8.9'
ARDUINO_LIBRARIES   = ARDUINO_DIR + '/libraries'
ARDUINO_BASE_LIBRARIES = ARDUINO_DIR + '/hardware/arduino/avr/cores/arduino'
LOCAL_PATH          = expanduser("~") + '/Arduino'
PATH                = LOCAL_PATH + '/include'
ARDUINO_INSTALLED_LIBRARIES = LOCAL_PATH + '/libraries'

def MyCopy(p):
    for subdir, dirs, files in os.walk(p):
        for file in files:
            filepath = subdir + os.sep + file
            if filepath.endswith(".h"):
                copy(filepath, PATH)

MyCopy(ARDUINO_INSTALLED_LIBRARIES)

CXXFLAGS            = ['-x','c++']

INCLUDES            = ['-I'+PATH]

def FlagsForFile(filename, **kwargs):
    flags = []
    flags += CXXFLAGS
    flags += INCLUDES
    return {
        'flags' : flags
    }

