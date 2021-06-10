function [p,t]=srrcFunction(beta,L,Nsym)
%生成平方根升余弦函数
% 输入参数
% alpha： 滚降因子
% L：过采样因子
% Nsym - 滤波器跨度（以符号为单位，持续时间,-Nsym/2~Nsym/2）
% 输出参数
%  p：输出时域信号波形的样点，对应的时间点是-Nsym/2:1/L:Nsym/2

Tsym=1; t=-(Nsym/2):1/L:(Nsym/2);%unit symbol duration time-base

num = sin(pi*t*(1-beta)/Tsym)+...
    ((4*beta*t/Tsym).*cos(pi*t*(1+beta)/Tsym));
den = pi*t.*(1-(4*beta*t/Tsym).^2)/Tsym;
p = 1/sqrt(Tsym)*num./den; 

p(ceil(length(p)/2))=1/sqrt(Tsym)*((1-beta)+4*beta/pi);
temp=(beta/sqrt(2*Tsym))*( (1+2/pi)*sin(pi/(4*beta)) ...
    + (1-2/pi)*cos(pi/(4*beta)));
p(t==Tsym/(4*beta))=temp;
p(t==-Tsym/(4*beta))=temp;
end