%LMS均衡器实例
clearvars; clc;close all
%rng default

b=[0.5 j -0.6];           % 定义信道冲激响应
M=2;                      % 调制阶数    
Nsym=10000;                % 传输的符号数目
d = ceil(M.*rand(1,Nsym));%生成随机符号
s = mpam_modulator(M,d);  %MPAM调制
r=filter(b,1,s);          % 信道输出
n=4;                      % 均衡器阶数
mu=.0001;                   % 步长 
delta=2;                  % 时延 delta,信号通过滤波器的时延

f =lms_equalizer(n,mu,r,d,delta); % 计算LMS均衡器抽头系数
yt=filter(f,1,r);            % 使用f均衡接收到的信号
dec=mpam_detector(M,yt);     % 解调判决
for sh=0:n                   % 如均衡器工作，有一个时延下的均衡误差为0
  err(sh+1)=sum(abs(dec(sh+1:Nsym)-d(1:Nsym-sh)));
end                          
err