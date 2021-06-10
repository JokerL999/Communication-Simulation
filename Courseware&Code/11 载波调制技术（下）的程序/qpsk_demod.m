function [a_cap] = qpsk_demod(r,fc,OF)
% QPSK解调
% 输入参数
%  r - 接收信号
%  fc- 载频[Hz]
%  OF - 过采样因子，fc的倍数，至少4以上
% 输出参数
% a_cap - 检测得到的数据流

fs = OF*fc; %采样频率
L = 2*OF; %一个符号周期（两路信号）的样点数
t=0:1/fs:(length(r)-1)/fs; %时间点函数

x=r.*cos(2*pi*fc*t); %I路
y=-r.*sin(2*pi*fc*t); %Q路
x = conv(x,ones(1,L));%I路积分（L个点，Tsym=2*Tb）
y = conv(y,ones(1,L));%Q路积分（L个点，Tsym=2*Tb）
x = x(L:L:end)  ;%I路 - 每隔Tsym取一个点
y = y(L:L:end);  %Q路 - 每隔Tsym取一个点

a_cap = zeros(1,2*length(x));
a_cap(1:2:end) = x.' > 0; 
a_cap(2:2:end) = y.' > 0; 

