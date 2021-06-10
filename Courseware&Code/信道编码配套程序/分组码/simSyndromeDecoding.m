clearvars; clc;

 G = [1 0 0 0 1 0 1;     % ���ɾ��� k x n
      0 1 0 0 1 1 1;
      0 0 1 0 1 1 0;
      0 0 0 1 0 1 1];
 
[k,n] = size(G); 
H = gen2parmat(G); % ����У��
syndromeTable = getSyndromeTable(G);%����У���ӽ����

% ��֤У���ӽ���
% �����
x = rand(1,k) > 0.5 % �������������Ϣ����
c = mod(x*G,2)      % �������Է�������

% �ŵ�
d = 1; % ����d��bit�Ĵ���
[E,nRows,nCols] = error_pattern_combos(d,n); % ����d�����ش��������ģʽ
index = randi([1,nRows]); %���ѡ��һ������ģʽ
e = E(index,:) 
r = mod(c + e,2) % ��������Ľ�������

% ���ջ�
s = mod(r*H.',2) % ����У����
s_dec = bi2de(s,'left-msb'); % У����ת��ʮ����

errorEst=syndromeTable(s_dec+1,2);% ��У���ӽ�������ҵ�����ģʽ��Ҳ������λ��
errorEst = cell2mat(errorEst)
recoveredCW = mod(r - errorEst,2) % �ָ�����

if (recoveredCW==c)
    disp('����ɹ�');
else
    disp('����ʧ��');
end