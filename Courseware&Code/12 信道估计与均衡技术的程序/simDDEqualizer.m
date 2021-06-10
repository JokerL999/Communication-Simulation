%面向判决（DD）的线性均衡器实例
clearvars; clc;close all
%rng default

b=[0.5 1 -0.6];              % 定义信道冲激响应
Nsym=1000; 
M=2;

d = ceil(M.*rand(Nsym,1));%生成随机符号
s = mpam_modulator(M,d);  %MPAM调制
r=filter(b,1,s);             % 信道输出
n=4;                     
f=[1 0 0 0]';           
mu=.1;                       % 算法步长
for i=n+1:Nsym                 
  rr=r(i:-1:i-n+1)';         
  e=sign(f'*rr)-f'*rr;       
  f=f+mu*conj(e)*rr;               
end

yt=filter(f,1,r);            % 使用f均衡接收到的信号
dec=mpam_detector(M,yt);     % 解调判决
for sh=0:n                   % 如均衡器工作，有一个时延下的均衡误差为0
  err(sh+1)=0.5*sum(abs(dec(sh+1:Nsym)-d(1:Nsym-sh)'));
end     
err