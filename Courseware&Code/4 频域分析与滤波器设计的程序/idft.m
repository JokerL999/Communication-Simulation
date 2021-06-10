function x=idft(Xk)
% 逆离散傅里叶变换
% 输入参数
% Xk - 频域信号
% 输出参数
% x -  时域信号

N=length(Xk);
xn=zeros(1,N);
x=zeros(1,N);
for n=0:N-1
   for k=0:N-1
     xn(k+1)=Xk(k+1)*exp(1i*2*pi*n*k/N);
   end
x(n+1)=sum(xn);
end
x=(1/N)*x;