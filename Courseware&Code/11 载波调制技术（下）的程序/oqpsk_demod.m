function [a_cap] = oqpsk_demod(r,N,fc,OF)
% OQPSK���
% �������
%  r - �����ź�
%  N -���ͷ�����Ŀ
%  fc- ��Ƶ[Hz]
%  OF - ���������ӣ�fc�ı���������4����
% �������
% a_cap - ���õ���������

fs = OF*fc; %����Ƶ��
L = 2*OF; %һ���������ڣ���·�źţ���������
t=0:1/fs:(length(r)-1)/fs; %ʱ��㺯��

x=r.*cos(2*pi*fc*t); %I·
y=-r.*sin(2*pi*fc*t); %Q·
x = conv(x,ones(1,L));%I·���֣�L���㣬Tsym=2*Tb��
y = conv(y,ones(1,L));%Q·���֣�L���㣬Tsym=2*Tb��
x = x(L:L:end-L);     %I· - ÿ��Tsymȡһ����
y = y(L+L/2:L:end-L/2); %Q· - ÿ��Tsymȡһ���㣬ʱ�Ӱ����������

a_cap = zeros(N,1);
a_cap(1:2:end) = x.' > 0; 
a_cap(2:2:end) = y.' > 0; 
