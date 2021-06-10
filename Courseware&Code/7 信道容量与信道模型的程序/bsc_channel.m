function y = bsc_channel(x,e)
% BSC信道
% 输入： x 输入符号；e：错误概率
% 输出： y 输出符号
y = x; 
errors = rand(1,length(x))<e; 
y(errors) = 1 - y(errors); % 反转信息比特