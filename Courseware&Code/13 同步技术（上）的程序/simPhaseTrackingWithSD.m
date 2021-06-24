% 利用最小化平方差（SD）跟踪相位
clearvars;close all;

Ts=1/10000;                 % 采样间隔
time=1;                     % 仿真时长
t=0:Ts:time-Ts;             % 仿真时间矢量
fc=100;                     % 载波频率
phoff=-0.8;                 % 相位
rp=cos(4*pi*fc*t+2*phoff);  % 平方器输出信号
mu=.001;                    % 算法步长
theta=zeros(1,length(t));   % 相位估计结果（保存空间）
theta(1)=0;                 % 初始相位
fl=25;                      % 平均窗长度
h=ones(1,fl)/fl;            % 平均系数
z=zeros(1,fl);              % 用于平均计算的buffer
f0=fc;                 
for k=1:length(t)-1           
  filtin=2*(rp(k)-0.5*cos(4*pi*f0*t(k)+2*theta(k)))...
      *sin(4*pi*f0*t(k)+2*theta(k));
  z=[z(2:fl), filtin];                
  theta(k+1)=theta(k)-mu*fliplr(h)*z'; % 更新
end
plot(t,theta)                          % 估计的相位变化趋势
title('利用最小化平方差（SD）跟踪相位')
xlabel('时间'); ylabel('相位')