function f_____ = check()

clear;

% �]����`
NOT_FOUND_____ = -404;
INTERNAL_ERROR_____ = -500;
EVALUATE_ERROR_____ = -600;

% �t�@�C�����Ƃ���`
ANSWER_DIR_____ = 'correct';   % �����o�̓v���O�����i�[�f�B���N�g����
LIST_____ = 'list.csv';          % ��o���҉񓚎҂�ID���X�g�t�@�C����
OUTPUT_____ = 'evaluaiton.csv';  % �]�����ʏo�̓t�@�C����

% �ۑ�̌����擾(�f�B���N�g���̑��݊m�F����)
kadai_num_____ = 0;
while exist( sprintf('kadai%d', kadai_num_____+1), 'dir')
    kadai_num_____ = kadai_num_____+1;
end

% ���҉񓚎�ID���擾
ID_LIST_____ = csvread(LIST_____);
id_____ = num2cell(ID_LIST_____);

% �]���i�[�p�z��
evaluation_____ = zeros(length(ID_LIST_____), kadai_num_____);

% kadai loop
for k_____ = 1:kadai_num_____
    kadai_name_____ = sprintf('kadai%d', k_____);
    % �����̎擾(�����X�N���v�g�̎��s)
    % �����X�N���v�g�̎��s�ŗ�O���o���ꍇ�͏C������ΕK�v�Ȃ̂�try-catch���Ȃ�
    run( sprintf('%s/%s.m', ANSWER_DIR_____, kadai_name_____));
    answer_____ = result;
    
    % id loop
    for n_____ = 1:length(ID_LIST_____)
    
        % �w�肵���ϐ��ȊO���폜
        clearvars -except NOT_FOUND_____ INTERNAL_ERROR_____ EVALUATE_ERROR_____ ANSWER_DIR_____ LIST_____ OUTPUT_____ kadai_num_____ ID_LIST_____ id_____ evaluation_____ k_____ kadai_name_____ answer_____ n_____
       
        % �񓚃v���O�����̎��s
        filename = sprintf('%s/%s_%d.m', kadai_name_____, kadai_name_____, ID_LIST_____(n_____));
        % �t�@�C�����݊m�F
        if exist(filename, 'file')
            % �񓚃X�N���v�g���s
            try
                run(filename);
            catch
                % �񓚃X�N���v�g���s���G���[
                evaluation_____(n_____, k_____) = INTERNAL_ERROR_____;
            end
            
            % result(��)�ϐ����݃`�F�b�N
            if exist('result', 'var')
                % ��r(�]��) -> �֐�(eval{k}.m���ɋL�q����)��p�ӂ���
                try
                    eval( sprintf('evaluation_____(n_____, k_____) = eval%d(answer_____, result);', k_____));
                    %evaluation_____(n_____, k_____)  = evaluate(answer_____, result);
                catch
                    % evaluate�֐����̃G���[
                    evaluation_____(n_____, k_____) = EVALUATE_ERROR_____;
                end
            else
                % result(��)�ϐ������݂��Ȃ�
                evaluation_____(n_____, k_____) = INTERNAL_ERROR_____;
            end
        else
            % �X�N���v�g�����݂��Ȃ�
            evaluation_____(n_____, k_____) = NOT_FOUND_____;
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