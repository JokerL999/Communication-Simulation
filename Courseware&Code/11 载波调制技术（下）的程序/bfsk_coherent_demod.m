function a_cap = bfsk_coherent_demod(r,Fc,Fd,L,Fs,phase)
% BFSK����ɽ��
% �������
%  r�������ź�
% Fc����Ƶ
% Fd������Fc��Ƶ��ƫ��
%  L���������ڵĲ�����Ŀ
% Fs������Ƶ��
% phase����������ʼ��λ
% �������
% a_cap - ���õ���������

t = (0:1:length(r)-1)/Fs; %ʱ��ʸ��
x = r.*(cos(2*pi*(Fc+Fd/2)*t+phase)-cos(2*pi*(Fc-Fd/2)*t+phase));
y = conv(x,ones(1,L)); %����
a_cap = y(L:L:end)>0;%���������
end