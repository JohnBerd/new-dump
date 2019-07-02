import os

CXXFLAGS            = ['-x','c++']
INCLUDES            = ['-I/usr/include', '-I/usr/local/include']

def FlagsForFile(filename, **kwargs):
    flags = []
    flags += CXXFLAGS
    flags += INCLUDES
    return {
        'flags' : flags
    }

