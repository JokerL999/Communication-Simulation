function [p,t]=raisedCosineFunction(alpha,L,Nsym)
%生成升余弦函数
% 输入参数
% alpha： 滚降因子
% L：过采样因子
% Nsym - 滤波器跨度（以符号为单位，持续时间,-Nsym/2~Nsym/2）
% 输出参数
%  p：输出时域信号波形的样点，对应的时间点是-Nsym/2:1/L:Nsym/2

Tsym=1; 
t=-(Nsym/2):1/L:(Nsym/2);
p = sin(pi*t/Tsym)./(pi*t/Tsym).*cos(pi*alpha*t/Tsym)./(1-(2*alpha*t/Tsym).^2);
p(ceil(length(p)/2))=1;%p(0)=1 
end