function Xk = dft(x)
% 离散傅里叶变换
% 输入参数
% x - 时域信号
% 输出参数
% Xk -频域信号

N=length(x);
Xk=zeros(1,N);
X=zeros(1,N);
 for k=0:N-1
    for n=0:N-1
      X(n+1)=x(n+1)*exp(-1i*2*pi*k*n/N);
    end
    Xk(k+1)=sum(X);
end
