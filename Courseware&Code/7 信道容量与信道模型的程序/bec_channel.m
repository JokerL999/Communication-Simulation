function y = bec_channel(x,e)
%BEC�ŵ�
% ���룺 x ������ţ�e����������
% ����� y �������
y = x; 
erasures = (rand(1,length(x))<=e);%����λ��
y(erasures) = -1; 