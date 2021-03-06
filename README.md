# matlab-answer-checker

- `check.m` : 回答プログラム(*.m)の結果が正解しているかを評価するMatlabプログラム
- `prepare.m` : 各userディレクトリから各kadaiディレクトリへコピーする
```
$ python prepare {path}
```

## 構成

### ディレクトリ構成
`{}`内は定義可能 or 任意
```
- check.m
- list.csv
- imgs
	- {img1}.jpg
	- {img2}.jpg
- eval1.m
- eval2.m
- {correct} [d]
	- kadai1.m
	- kadai2.m
- kadai1 [d]
	- kadai1_{1200xxx}.m
	- kadai1_{1200yyy}.m
- kadai2 [d]
	- kadai2_{1200xxx}.m
	- kadai2_{1200yyy}.m
```

### 出力ファイル構成

- 正常実行時 : 評価関数に依存
- 回答ファイル存在エラー : `NOT_FOUND`に定義 (default=-404)
- 回答ファイル実行時エラー : `INTERNAL_ERROR`に定義 (default=-500)
- 評価関数実行時エラー : `EVALUATE_ERROR`に定義 (default=-600)


### 内部構成
- 最終結果を`result`変数に格納する(正解プログラム・回答プログラム共に)
- 回答プログラムを ディレクトリ`kadai{k}`内に ファイル`kadai{k}_{ID}.m` で置く
- 正解出力プログラム名を`check.m`内に定義された`ANSWER_FILE`変数のディレクトリ(デフォルトでは、`ANSWER_FILE='correct'`)内のファイル`kadai{k}.m`で置く
- 回答プログラム内で読み込む画像名を`check.m`内に`INPUT_IMG_FILE`で定義する(デフォルトでは、`INPUT_IMG_FILE='kut.jpg'`)
- テストに用いる画像を `check.m`内に定義された `IMGS`変数のディレクトリ(デフォルトでは、`IMGS=imgs`)内に置く(`*.jpg`のみ)
- `eval{k}.m`内に関数`eval{k}`を定義し、正解と回答を比較して評価する関数を用意する(課題ごとに評価が異なる / 複数出力への対応も可能)


## TODO
- [x] 複数画像に対するcheck
- [ ] テスト画像の対応フォーマットを`*.jpg`のみにしている件
- [ ] 複数画像テストの評価指標について(現状sum)

## CHECK
- 実行ディレクトリ直下に`eval{k}.m`が転がってるのがダサくて、さらに`eval`関数を用いているのがよろしくない気がする
