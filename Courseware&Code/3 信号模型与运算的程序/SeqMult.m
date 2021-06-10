function [x,n] = SeqMult(x1,n1,x2,n2)
% 实现序列相乘 x[n] = x1[n]+x2[n]
% 输入参数
%  x1 ：定义在时间矢量n1上的序列1
%  x2 ：定义在时间矢量n2上的序列2 (n2 可与 n1 不同)
% 输出参数
%  x：定义在时间矢量n上的序列积

n=min(min(n1),min(n2)):max(max(n1),max(n2)); % 生成序列积的时间矢量
s1=zeros(1,length(n));s2=s1;                 % 根据序列积的时间矢量，分配存储空间          
s1(((n>=min(n1))&(n<=max(n1))==1))=x1;       % 将x1按照时间矢量n复制到s1
s2(((n>=min(n2))&(n<=max(n2))==1))=x2;       % 将x2按照时间矢量n复制到s2 
x=s1.*s2;                                    % 时间矢量对齐后序列相乘     
end

