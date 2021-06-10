function [stdArray] = standardArray(G)
% ���ܣ��������ɾ������ɱ�׼����
% ���룺G ���ɾ���
% �����stdArray ��׼����
[k,n] = size(G); 

M = dec2bin(0:2^k-1)-'0'; %k����Ϣλ�����п�����Ϣ����
C = mod(M*G,2);% ���п��ܵ����֣�CҲ�����뱾

S = C;%S�����׼���������е����֣����ں����ѭ������
stdArray = mat2cell(C,ones(1,2^k),n).'; 

for d=1:n %�������п��ܵĴ���
    [E,nRows,~] = error_pattern_combos(d,n);%��������d�������ģʽ
    for j=1:nRows %���ÿ������ģʽ�����ɴ�������
        if sum(ismember(E(j,:),S,'rows'))==0 %�жϴ���ģʽ��S���Ƿ����
            %���������ģʽ��S�в�����
            coset = mod(C + repmat(E(j,:),2^k,1),2); % ���뱾��2^k�����֣���һ���յ�j������ģʽ�����ɴ�������
            S = vertcat(S,coset);%���±�׼���������е�����
            stdArray = vertcat(stdArray,mat2cell(coset,ones(1,2^k),n).');%ת����Ԫ���洢
        end
    end
end