function y = bsc_channel(x,e)
% BSC�ŵ�
% ���룺 x ������ţ�e���������
% ����� y �������
y = x; 
errors = rand(1,length(x))<e; 
y(errors) = 1 - y(errors); % ��ת��Ϣ����