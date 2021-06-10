function [a_cap] = msk_demod(r,N,fc,OF)
% MSK解调
% 输入参数
%  r - 接收信号
%  N -发送符号数目
%  fc- 载频[Hz]
%  OF - 过采样因子，fc的倍数，至少4以上
% 输出参数
% a_cap - 检测得到的数据流

L = 2*OF; %一个符号周期的采样数
%cosine and sine functions for half-sinusoid shaping
Fs=OF*fc;
Ts=1/Fs;
Tb = OF*Ts;
t=(-OF:1:length(r)-OF-1)/Fs;
x=abs(cos(pi*t/(2*Tb)));
y=abs(sin(pi*t/(2*Tb)));

u=r.*x.*cos(2*pi*fc*t);
v=-r.*y.*sin(2*pi*fc*t); 
iHat = conv(u,ones(1,L));%I路积分（L个点，Tsym=2*Tb）
qHat = conv(v,ones(1,L));%Q路积分（L个点，Tsym=2*Tb）
iHat= iHat(L:L:end-L);%I路 - 每隔Tsym取一个点
qHat= qHat(L+L/2:L:end-L/2);%Q路 - 每隔Tsym取一个点，时延半个符号周期

a_cap = zeros(N,1);
a_cap(1:2:end) = iHat > 0; 
a_cap(2:2:end) = qHat > 0; 