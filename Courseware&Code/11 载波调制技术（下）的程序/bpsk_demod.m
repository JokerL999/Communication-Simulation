function [ak_cap] = bpsk_demod(r_bb,L)
% 解调基带BPSK调制信号
%r_bb - 基带调制信号
%L - 过采样因子(Tsym/Tsam)
%ak_cap - 检测出的二进制数据流
x=real(r_bb); %I路
x = conv(x,ones(1,L));%积分L个样点（Tsym时间）
x = x(L:L:end);  %I路，降采样
ak_cap = (x > 0).'; %门限检测