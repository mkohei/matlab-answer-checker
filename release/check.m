function f_____ = check()

clear;

% 評価定義
NOT_FOUND_____ = -404;
INTERNAL_ERROR_____ = -500;
EVALUATE_ERROR_____ = -600;

% ファイル名とか定義
ANSWER_DIR_____ = 'correct';     % 正解出力プログラム格納ディレクトリ名
LIST_____ = 'list.csv';          % 提出期待回答者のIDリストファイル名
OUTPUT_____ = 'evaluaiton.csv';  % 評価結果出力ファイル名
IMGS_____ = 'imgs';              % テスト用画像の格納ディレクトリ
INPUT_IMG_NAME_____ = 'kut.jpg';      % テスト時の画像ファイル名

% 課題の個数を取得(ディレクトリの存在確認から)
kadai_num_____ = 0;
while exist( sprintf('kadai%d', kadai_num_____+1), 'dir')
    kadai_num_____ = kadai_num_____+1;
end

% 期待回答者IDを取得
ID_LIST_____ = csvread(LIST_____);
id_____ = num2cell(ID_LIST_____);

% テスト画像パスを取得
% TODO: JPGだけに対応
imgs_____ = dir( strcat(IMGS_____, '/*.jpg'));

% 評価格納用配列
evaluation_____ = zeros(length(ID_LIST_____), kadai_num_____);

% kadai loop
for k_____ = 1:kadai_num_____
    kadai_name_____ = sprintf('kadai%d', k_____);
    
    % 課題全体(全テスト画像を通した)評価
    %kadai_evaluation_____ = 0;
    
    % test imgs loop
    for t_____ = 1:length(imgs_____)
        
        % テスト画像の用意(コピー)
        copyfile( sprintf('%s/%s', IMGS_____, imgs_____(t_____).name), sprintf('%s/%s', ANSWER_DIR_____, INPUT_IMG_NAME_____));
        copyfile( sprintf('%s/%s', IMGS_____, imgs_____(t_____).name), sprintf('%s/%s', kadai_name_____, INPUT_IMG_NAME_____));
        
        % 正解の取得(正解スクリプトの実行)
        % 正解スクリプトの実行で例外が出た場合は修正が絶対必要なのでtry-catchしない
        run( sprintf('%s/%s.m', ANSWER_DIR_____, kadai_name_____));
        answer_____ = result;

        % id loop
        for n_____ = 1:length(ID_LIST_____)

            % 指定した変数以外を削除
            clearvars -except NOT_FOUND_____ INTERNAL_ERROR_____ EVALUATE_ERROR_____ ANSWER_DIR_____ LIST_____ OUTPUT_____ kadai_num_____ ID_LIST_____ id_____ evaluation_____ k_____ kadai_name_____ answer_____ n_____ INPUT_IMG_NAME_____ imgs_____ t_____ IMGS_____

            % figure window削除
            close all;

            % 回答プログラムの実行
            filename = sprintf('%s/%s_%d.m', kadai_name_____, kadai_name_____, ID_LIST_____(n_____));
            % ファイル存在確認
            if exist(filename, 'file')
                % 回答スクリプト実行
                try
                    run(filename);
                catch ME
                    ME
                    % 回答スクリプト実行時エラー
                    evaluation_____(n_____, k_____) = INTERNAL_ERROR_____;
                end

                % result(回答)変数存在チェック
                if exist('result', 'var')
                    % 比較(評価) -> 関数(eval{k}.m内に記述する)を用意する
                    try
                        if evaluation_____(n_____, k_____) < 0
                            % ErrorValueを保持
                        else
                            e = eval( sprintf('eval%d(answer_____, result);', k_____));
                            % TODO: 複数テスト画像の評価の扱い
                            % 現状: 加算(平均した方が良い?)
                            evaluation_____(n_____, k_____) = evaluation_____(n_____, k_____) + e;
                        end
                    catch ME
                        ME
                        % evaluate関数内のエラー
                        evaluation_____(n_____, k_____) = EVALUATE_ERROR_____;
                    end
                else
                    % result(回答)変数が存在しない
                    evaluation_____(n_____, k_____) = INTERNAL_ERROR_____-1;
                end
            else
                % スクリプトが存在しない
                evaluation_____(n_____, k_____) = NOT_FOUND_____;
            end
        end
    end
    
end

id = id_____;
kadai = evaluation_____;
%T = table(ID_LIST_____, evaluation_____);
%T = table(id_____, evaluation_____);
T = table(id, kadai);
writetable(T, OUTPUT_____);

f_____ = T;

end
