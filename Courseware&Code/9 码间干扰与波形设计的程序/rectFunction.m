function [p,t]=rectFunction(L,Nsym)
% 生成方波脉冲
%L - 过采样因子
%Nsym - 波形长度，单位：符号
%p 采样点
%t 采样时间-(Nsym/2):1/L:(Nsym/2)

Tsym=1;t=-(Nsym/2):1/L:(Nsym/2);
p=(t > -Tsym/2) .* (t <= Tsym/2);
end