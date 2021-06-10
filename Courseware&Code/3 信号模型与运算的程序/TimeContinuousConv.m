function [x,n]=TimeContinuousConv(x1,n1,x2,n2,p)
% 计算时间连续信号抽样的卷积 
% 输入参数
% x1: x1[n]的非零样值向量及其对应的时间矢量n1;
% x2: x2[n]的非零样值向量及其对应的时间矢量n2;
% p： 采样时间间隔
% 输出参数
% x: 卷积结果序列 x(n)及其对应的时间矢量n

[x,n]=TimeDiscreteConv(x1,n1,x2,n2);
x=x*p;
n=n*p;
end

