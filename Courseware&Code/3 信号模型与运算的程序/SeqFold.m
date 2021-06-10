function [x,n] = SeqFold(x1,n)
% 实现序列反折 x[n] = x1[-n]
% 输入参数
%  x1 ：定义在时间矢量n上的序列
% 输出参数
%  x：定义在时间矢量n上的反折后的序列

x = fliplr(x1); 
n = -fliplr(n);
end

