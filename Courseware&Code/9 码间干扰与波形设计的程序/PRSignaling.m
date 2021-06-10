function [b,t]=PRSignaling(Q,L,Nsym)
%生成部分响应系统的冲激响应
%输入参数
%  Q - Q滤波器抽头值 
%  L - 过采样因子
%  Nsym - 滤波器跨度
% 输出参数
%  b(t) 冲激响应

% 给滤波器一个冲激信号，得到响应信号
qn =  filter(Q,1,[ 0 0 0 0 0 1 0 0 0 0 0 0]);
q=[qn ;zeros(L-1,length(qn))];%上采样，每两个值之间插L-1个零
q=q(:).';
Tsym=1; %符号时长
t=-(Nsym/2):1/L:(Nsym/2);
g = sin(pi*t/Tsym)./(pi*t/Tsym); g(isnan(g)==1)=1; %sinc函数
b = conv(g,q,'same');%卷积 q(t) and g(t)
end