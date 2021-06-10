function [p,t]=sincFunction(L,Tsym,Nsym)
% 生成sinc函数
% 输入参数
%  L：过采样因子（每个符号的样点数目）
%  Tsym:符号时间
%  Nsym：滤波器跨度（符号持续时间）
% 输出参数
%  p：输出时域信号波形的样点，对应的时间点是-Nsym/2:1/L:Nsym/2
t=-(Nsym/2)*Tsym:Tsym/L:(Nsym/2)*Tsym;
p = sin(pi*t/Tsym)./(pi*t/Tsym);
p(ceil(length(p)/2))=1; %设 sinc(0/0)为1
end