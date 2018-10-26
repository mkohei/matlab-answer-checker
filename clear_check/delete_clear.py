# coding=utf

import sys
import os
import glob2
import parse
import codecs


def getPath():
    if len(sys.argv) > 1:
        path = sys.argv[1]
        if os.path.exists(path):
            return path
    return '.'


def main():
    PATH = getPath()

    kadaifiles = glob2.glob("{}/contain_clear/*.m".format(PATH))

    for mfilepath in kadaifiles:
        mfilename = os.path.basename(mfilepath)

        result = parse.parse("{}_{}.m", mfilename)
        kadainame = result[0]
        idstr = result[1]

        try:
            with codecs.open(mfilepath, 'r', 'shift-jis') as mfile:
                lines = mfile.readlines()
        except UnicodeDecodeError:
            with codecs.open(mfilepath, 'r', 'utf-8') as mfile:
                lines = mfile.readlines()
        finally:
            ...

        newcode = ""
        for line in lines:
            if 'clear' in line:
                ...
            else:
                newcode += line
        
        dirname = "{}/{}".format(PATH, kadainame)
        if os.path.exists(dirname) is False:
            os.makedirs(dirname)
        with open("{}/{}".format(dirname, mfilename), 'w') as f:
            f.write(newcode)




if __name__ == '__main__':
    main()