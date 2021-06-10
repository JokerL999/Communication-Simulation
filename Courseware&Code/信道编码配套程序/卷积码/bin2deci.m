function y=bin2deci(x)
%功能：保存在数组中的二进制转成十进制数
l=length(x);
y=(l-1:-1:0);
y=2.^y;
y=x*y';