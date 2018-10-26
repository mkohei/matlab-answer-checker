# coding=utf8

import sys
import os
import glob
import shutil

import parse
import codecs
import re


INPUT_IMG_NAME = 'kut.jpg'


def getPath():
    if len(sys.argv) > 1:
        path = sys.argv[1]
        if os.path.exists(path):
            return path
    return '.'


def get_code_lines(mfilepath):
    try:
        with codecs.open(mfilepath, 'r', 'shift-jis') as mfile:
            lines = mfile.readlines()
    except:
        with codecs.open(mfilepath, 'r', 'utf-8') as mfile:
            lines = mfile.readlines()
    finally:
        ...
    
    return lines







################
##### main #####
################
if __name__ == '__main__':
    # PATHの取得
    PATH = getPath()

    # 全ファイル取得
    for _dir in os.listdir(PATH):
        mfiles = glob.glob("{}/{}/*.m".format(PATH, _dir))
        for filepath in mfiles:
            filename = os.path.basename(filepath)

            # fix filename
            if "-" in filename:
                print("[Invalid filename (fixed)] {}".format(filename))
                filename = re.sub(r"-", "_", filename) # '-' -> '_'
            if filename.islower() is False:
                print("[Invalid filename (fixed)] {}".format(filename))
                filename = filename.lower()

            result = parse.parse("kadai{:d}_{:d}.m", filename)

            # parse error
            if result is None:
                newdirpath = "./other"
                if os.path.exists(newdirpath) is False:
                    os.mkdir(newdirpath)
                shutil.copyfile(filepath, "{}/{}".format(newdirpath, filename))
            else:
                # 課題ごとのディレクトリ
                newdir = "kadai{}".format(result[0])
                newdirpath = "./{}".format(newdir)
                if os.path.exists(newdirpath) is False:
                    os.mkdir(newdirpath)
                
                lines = get_code_lines(filepath)
                newcode = ""
                resultcnt = 0
                for line in lines:
                    if 'clear' in line:
                        print("[Detect 'clear' (fixed)] {}".format(filename))
                        continue
                    imread = "imread('{}')".format(INPUT_IMG_NAME)
                    if "imread" in line and imread not in line:
                        line = re.sub(r"imread\('.+'\)", imread, line)
                        print("[Load file name is invalid (fixed)] {}".format(filename))
                    # TODO: result (only check)
                    if 'result' in line:
                        resultcnt += 1
                    newcode += line
                if resultcnt == 0:
                    print("[Undifined 'result' (only check)] {}".format(filename))

                outfilepath = "{}/{}".format(newdirpath, filename.lower())
                with open(outfilepath, 'w') as f:
                    f.write(newcode)
                #shutil.copyfile(filepath, "{}/{}".format(newdirpath, filename))
