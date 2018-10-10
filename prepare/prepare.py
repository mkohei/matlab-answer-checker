# coding=utf8

import sys
import os
import glob
import shutil

import parse



def getPath():
    if len(sys.argv) > 1:
        path = sys.argv[1]
        if os.path.exists(path):
            return path
    return '.'






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
                shutil.copyfile(filepath, "{}/{}".format(newdirpath, filename))
