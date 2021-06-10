
M=4;    %阶数
N=1e5;  %符号数
a=randi([0,M-1],N,1); %输入随机符号序列
Q=[1 1]; % q0=1,q1=1, PR Class 1 Scheme (Duobinary coding)

x=zeros(size(a)); %预编码输出的存储空间
D=zeros(length(Q),1); %用于生成预编码输出的历史预编码滑动存储空间

for k=1:length(a)
  x(k)=mod(a(k)-(D(2:end).*Q(2:end)),M);
  D(2)=x(k);
  if length(D)>2
   D(3:end)=D(2:end-1); %存储器内容移位
  end
end
disp(x); %显示预编码结果
bn=filter(Q,1,x)%相关编码得到接收信号，可在这里添加噪声
acap=mod(bn,M) %模M运算
errors=sum(acap~=a) %错误数目