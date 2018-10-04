clear;

% �t�@�C�����Ƃ���`
ANSWER_FILE = 'correct.m';  % �����o�̓v���O�����t�@�C����
DIR = 'files';              % �𓚃v���O�����t�@�C���i�[�f�B���N�g��
OUTPUT = 'evaluaiton.csv';  % �]�����ʏo�̓t�@�C����

% �񓚂̎擾
run(ANSWER_FILE);
answer = result;

% �𓚃v���O�����̈ꗗ�擾
files = dir(strcat(DIR, '/*.m'));

% �]���i�[�p�z��
id = cell(length(files), 1);
evaluation = zeros(length(files), 1);

for n = 1:length(files)
    
    % �w�肵���ϐ��ȊO���폜
    clearvars -except DIR OUTPUT answer n files id evaluation
    
    % �𓚃v���O�����̎��s
    % TODO: ���s���G���[�̃n���h���Ƃ�
    filename = strcat(DIR, '/', files(n).name);
    run(filename);
    
    % ��r(�]��) -> �֐�(evaluation.m���ɋL�q)��p�ӂ���
    % TODO: result�ɒl�������Ă��Ȃ��Ƃ�
    id(n) = cellstr( files(n).name(1:end-2) );
    evaluation(n)  = evaluate(answer, result);
end

T = table(id, evaluation);
writetable(T, OUTPUT);