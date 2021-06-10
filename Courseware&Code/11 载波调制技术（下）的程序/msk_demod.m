function [a_cap] = msk_demod(r,N,fc,OF)
% MSK���
% �������
%  r - �����ź�
%  N -���ͷ�����Ŀ
%  fc- ��Ƶ[Hz]
%  OF - ���������ӣ�fc�ı���������4����
% �������
% a_cap - ���õ���������

L = 2*OF; %һ���������ڵĲ�����
%cosine and sine functions for half-sinusoid shaping
Fs=OF*fc;
Ts=1/Fs;
Tb = OF*Ts;
t=(-OF:1:length(r)-OF-1)/Fs;
x=abs(cos(pi*t/(2*Tb)));
y=abs(sin(pi*t/(2*Tb)));

u=r.*x.*cos(2*pi*fc*t);
v=-r.*y.*sin(2*pi*fc*t); 
iHat = conv(u,ones(1,L));%I·���֣�L���㣬Tsym=2*Tb��
qHat = conv(v,ones(1,L));%Q·���֣�L���㣬Tsym=2*Tb��
iHat= iHat(L:L:end-L);%I· - ÿ��Tsymȡһ����
qHat= qHat(L+L/2:L:end-L/2);%Q· - ÿ��Tsymȡһ���㣬ʱ�Ӱ����������

a_cap = zeros(N,1);
a_cap(1:2:end) = iHat > 0; 
a_cap(2:2:end) = qHat > 0; 