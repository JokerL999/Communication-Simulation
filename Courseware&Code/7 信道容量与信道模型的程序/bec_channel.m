function y = bec_channel(x,e)
%BEC信道
% 输入： x 输入符号；e：擦除概率
% 输出： y 输出符号
y = x; 
erasures = (rand(1,length(x))<=e);%擦除位置
y(erasures) = -1; 