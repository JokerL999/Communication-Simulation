function y=deci2bin(x,l)
% 功能：十进制数转成二进制，结果保存在数组中
y = zeros(1,l);	
i = 1;
while x>=0 & i<=l
	y(i)=rem(x,2);
	x=(x-y(i))/2;
	i=i+1;
end
y=y(l:-1:1);