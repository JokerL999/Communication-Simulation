function [a,xx]=FouierSeries(x,T,N)
% 傅里叶级数分解与综合实现
% 输入参数
% x - 符号表示的周期信号
% T - 周期
% N - 傅里叶级数系数的范围：-N~N
% 输出参数
% a - 傅里叶级数系数
% xx- 近似综合信号

  syms t
  t0=0;
  w=2*pi/T;
  a=zeros(1,2*N+1);
  for k=-N:N
    a(k+N+1)=(1/T)*int(x*exp(-1i*k*w*t),t,t0,t0+T); % 计算傅里叶级数
  end
  for k=-N:N
    ex(k+N+1)=exp(1i*k*w*t);
  end
  xx=sum(a.*ex);
end