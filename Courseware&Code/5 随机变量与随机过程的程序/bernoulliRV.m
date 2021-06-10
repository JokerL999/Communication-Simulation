function X = bernoulliRV(L,p)
%生成参数为p的伯努利分布随机数
% 输入参数
% L：生成的序列长度；p：参数
% 输出参数
% X：随机序列
U = rand(1,L);%生成长度为L的在(0,1)上均匀分布的随机序列
X = (U<p);
end