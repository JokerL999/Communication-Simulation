function [s_bb,t] = bpsk_mod(ak,L)
% 使用BPSK调制二进制数据流
% 输入参数
%  ak - 输入二进制数据流
%  L  - 过采样因子(Tsym/Tsam)
% 输出参数
%  s_bb - BPSK调制信号
%  t -    调制信号的时间矢量

N = length(ak); %符号数
a = 2*ak-1; %BPSK调制
ai=repmat(a,1,L).'; %过采样
ai = ai(:).';%串行化
t=0:N*L-1; %时间矢量
s_bb = ai;%输出基带调制信号