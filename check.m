clear;

% ファイル名とか定義
ANSWER_FILE = 'correct.m';  % 正解出力プログラムファイル名
DIR = 'files';              % 解答プログラムファイル格納ディレクトリ
OUTPUT = 'evaluaiton.csv';  % 評価結果出力ファイル名

% 回答の取得
run(ANSWER_FILE);
answer = result;

% 解答プログラムの一覧取得
files = dir(strcat(DIR, '/*.m'));

% 評価格納用配列
id = cell(length(files), 1);
evaluation = zeros(length(files), 1);

for n = 1:length(files)
    
    % 指定した変数以外を削除
    clearvars -except DIR OUTPUT answer n files id evaluation
    
    % 解答プログラムの実行
    % TODO: 実行時エラーのハンドルとか
    filename = strcat(DIR, '/', files(n).name);
    run(filename);
    
    % 比較(評価) -> 関数(evaluation.m内に記述)を用意する
    % TODO: resultに値が入っていないとか
    id(n) = cellstr( files(n).name(1:end-2) );
    evaluation(n)  = evaluate(answer, result);
end

T = table(id, evaluation);
writetable(T, OUTPUT);