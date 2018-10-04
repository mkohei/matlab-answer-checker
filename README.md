# matlab-answer-checker

回答プログラム(*.m)の結果が正解しているかを評価するMatlabプログラム

## 構成

- 最終結果を`result`変数に格納する(正解プログラム・回答プログラム共に)
- 回答プログラムを`check.m`内に定義された`DIR`変数のディレクトリ内に置く(デフォルトでは `DIR='files'`)
- 正解出力プログラム名を`check.m`内に定義された`ANSWER_FILE`変数のファイル名にする
- `evaluate.m`内に関数`evaluate`を定義し、正解と回答を比較して評価する関数を用意する(課題ごとに評価が異なる / 複数出力への対応も可能)

## TODO

- [ ] 回答(/正解)プログラムの実行時エラーのハンドル
- [ ] 回答(/正解)プログラム実行後、`result`変数に値が入っていない場合の対応