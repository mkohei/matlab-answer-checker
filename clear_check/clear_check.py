# coding=utf8

""" clean　スクリプト排除 """

import glob2
import sys
import os
import codecs
import shutil

def getPath():
    if len(sys.argv) > 1:
        path = sys.argv[1]
        if os.path.exists(path):
            return path
    return '.'

def main():
    PATH = getPath()

    kadaidirs = glob2.glob("{}/kadai*".format(PATH))
    for kadaidir in kadaidirs:
        mfiles = glob2.glob("{}/*.m".format(kadaidir))

        for mfilepath in mfiles:
            #print(mfilepath)

            try:
                with codecs.open(mfilepath, 'r', 'shift-jis') as mfile:
                    code = mfile.read()
            except UnicodeDecodeError:
                with codecs.open(mfilepath, 'r', 'utf-8') as mfile:
                    code = mfile.read()
            finally:
                ...

            if 'clear' in code:
                senddir = "{}/contain_clear".format(PATH)
                if not os.path.exists(senddir):
                    os.makedirs(senddir)
                sendpath = "{}/{}".format(senddir, os.path.basename(mfilepath))
                shutil.move(mfilepath, sendpath)
                print("{}->{}".format(mfilepath, sendpath))


if __name__ == '__main__':
    main()
