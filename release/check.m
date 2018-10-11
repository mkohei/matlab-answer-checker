function f_____ = check()

clear;

% �]����`
NOT_FOUND_____ = -404;
INTERNAL_ERROR_____ = -500;
EVALUATE_ERROR_____ = -600;

% �t�@�C�����Ƃ���`
ANSWER_DIR_____ = 'correct';     % �����o�̓v���O�����i�[�f�B���N�g����
LIST_____ = 'list.csv';          % ��o���҉񓚎҂�ID���X�g�t�@�C����
OUTPUT_____ = 'evaluaiton.csv';  % �]�����ʏo�̓t�@�C����
IMGS_____ = 'imgs';              % �e�X�g�p�摜�̊i�[�f�B���N�g��
INPUT_IMG_NAME_____ = 'kut.jpg';      % �e�X�g���̉摜�t�@�C����

% �ۑ�̌����擾(�f�B���N�g���̑��݊m�F����)
kadai_num_____ = 0;
while exist( sprintf('kadai%d', kadai_num_____+1), 'dir')
    kadai_num_____ = kadai_num_____+1;
end

% ���҉񓚎�ID���擾
ID_LIST_____ = csvread(LIST_____);
id_____ = num2cell(ID_LIST_____);

% �e�X�g�摜�p�X���擾
% TODO: JPG�����ɑΉ�
imgs_____ = dir( strcat(IMGS_____, '/*.jpg'));

% �]���i�[�p�z��
evaluation_____ = zeros(length(ID_LIST_____), kadai_num_____);

% kadai loop
for k_____ = 1:kadai_num_____
    kadai_name_____ = sprintf('kadai%d', k_____);
    
    % �ۑ�S��(�S�e�X�g�摜��ʂ���)�]��
    %kadai_evaluation_____ = 0;
    
    % test imgs loop
    for t_____ = 1:length(imgs_____)
        
        % �e�X�g�摜�̗p��(�R�s�[)
        copyfile( sprintf('%s/%s', IMGS_____, imgs_____(t_____).name), sprintf('%s/%s', ANSWER_DIR_____, INPUT_IMG_NAME_____));
        copyfile( sprintf('%s/%s', IMGS_____, imgs_____(t_____).name), sprintf('%s/%s', kadai_name_____, INPUT_IMG_NAME_____));
        
        % �����̎擾(�����X�N���v�g�̎��s)
        % �����X�N���v�g�̎��s�ŗ�O���o���ꍇ�͏C������ΕK�v�Ȃ̂�try-catch���Ȃ�
        run( sprintf('%s/%s.m', ANSWER_DIR_____, kadai_name_____));
        answer_____ = result;

        % id loop
        for n_____ = 1:length(ID_LIST_____)

            % �w�肵���ϐ��ȊO���폜
            clearvars -except NOT_FOUND_____ INTERNAL_ERROR_____ EVALUATE_ERROR_____ ANSWER_DIR_____ LIST_____ OUTPUT_____ kadai_num_____ ID_LIST_____ id_____ evaluation_____ k_____ kadai_name_____ answer_____ n_____ INPUT_IMG_NAME_____ imgs_____ t_____ IMGS_____

            % �񓚃v���O�����̎��s
            filename = sprintf('%s/%s_%d.m', kadai_name_____, kadai_name_____, ID_LIST_____(n_____));
            % �t�@�C�����݊m�F
            if exist(filename, 'file')
                % �񓚃X�N���v�g���s
                try
                    run(filename);
                catch ME
                    ME
                    % �񓚃X�N���v�g���s���G���[
                    evaluation_____(n_____, k_____) = INTERNAL_ERROR_____;
                end

                % result(��)�ϐ����݃`�F�b�N
                if exist('result', 'var')
                    % ��r(�]��) -> �֐�(eval{k}.m���ɋL�q����)��p�ӂ���
                    try
                        if evaluation_____(n_____, k_____) < 0
                            % ErrorValue��ێ�
                        else
                            e = eval( sprintf('eval%d(answer_____, result);', k_____));
                            % TODO: �����e�X�g�摜�̕]���̈���
                            % ����: ���Z(���ς��������ǂ�?)
                            evaluation_____(n_____, k_____) = evaluation_____(n_____, k_____) + e;
                        end
                    catch ME
                        ME
                        % evaluate�֐����̃G���[
                        evaluation_____(n_____, k_____) = EVALUATE_ERROR_____;
                    end
                else
                    % result(��)�ϐ������݂��Ȃ�
                    evaluation_____(n_____, k_____) = INTERNAL_ERROR_____-1;
                end
            else
                % �X�N���v�g�����݂��Ȃ�
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