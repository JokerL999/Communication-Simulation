function a_cap = bfsk_noncoherent_demod(r,Fc,Fd,L,Fs)
% BFSK�ķ���ɽ��
% �������
%  r�������ź�
% Fc����Ƶ
% Fd������Fc��Ƶ��ƫ��
%  L���������ڵĲ�����Ŀ
% Fs������Ƶ��
% �������
% a_cap - ���õ���������

t = (0:1:length(r)-1)/Fs; 
F1 = (Fc+Fd/2); 
F2 = (Fc-Fd/2);

%4������ز��ź�
p1c = cos(2*pi*F1*t); 
p1s = -sin(2*pi*F1*t); 
p2c = cos(2*pi*F2*t);
p2s = -sin(2*pi*F2*t);

%����
r1c = conv(r.*p1c,ones(1,L));
r1s = conv(r.*p1s,ones(1,L));
r2c = conv(r.*p2c,ones(1,L)); 
r2s = conv(r.*p2s,ones(1,L)); 

%�²���
r1c = r1c(L:L:end); 
r1s = r1s(L:L:end);
r2c = r2c(L:L:end);
r2s = r2s(L:L:end);

%ƽ�����
x = r1c.^2 + r1s.^2;
y = r2c.^2 + r2s.^2;

a_cap=(x-y)>0; %�о�