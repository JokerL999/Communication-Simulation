function [syndromeTable] = getSyndromeTable(G)
% ���ܣ�����У���ӽ����
% ���룺G ���ɾ���
% �����syndromeTable У���ӽ����

H = gen2parmat(G);% �����ɾ��� G,����õ�У�����

A = standardArray(G);% �����׼����
B = H.';

S_full = cell(size(A));% �Ա�׼�����е��������֣�����У����
for ii = 1:numel(A)        
   S_full{ii} = mod(A{ii}*B,2);        
end

S_dec=bi2de(cell2mat(S_full(:,1)),'left-msb');% ��У����ʸ�����ʮ������
%У�������׼�����еĵ�һ�У�����ģʽ�����У���ӽ����
syndromeTable = [num2cell(S_dec) A(:,1)];  
syndromeTable = sortrows(syndromeTable,1);%������У����
