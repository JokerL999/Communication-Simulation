%锁相环仿真
clear, close all

Tsym=1;        %符号周期
Rsym=1/Tsym;   %符号速率

Fc=4*Rsym;     %载频
Fsam=4*Fc;     %采样频率
Tsam=1/Fsam;   %采样周期
L=Tsym/Tsam;   %每符号样点数 

Nsym=30;
NT=Nsym*L; 
tt=[0:NT]*Tsam; % 仿真时间范围 0到N_Iter个采样点

wc=2*pi*Fc;      %载波角频率
phi=pi/2 + pi/40*sin(0.01*pi*tt/Tsam);   % 模拟输入信号中变化的相位 

zeta=sqrt(0.5);  %阻尼系数
wn=wc/16;        %自然频率，通常小于载频的1/15

% 滤波器参数
T2=max(2*zeta/wn,Tsam/pi);
T1=10*T2;
Kc=2*wn^2*T1; 
% 利用双线性变换法，把模拟的环路滤波器(T2*s+1)/(T1*s)离散化
% [bLF,aLF]=bilinear([T2 1],[T1 0],1/Tsam,1/T2/2/pi)
[bLF,aLF]=bilinear([T2 1],[T1 0],1/Tsam);
% 利用双线性变换法，把VCO (Kv/s)离散化
[bVCO,aVCO]=bilinear(Kc,[1 0],1/Tsam);

% 初始化信号空间
xin=zeros(1,NT);     %输入信号
xout=zeros(1,NT);    %VCO输出信号
e=zeros(1,NT);       %PD输出信号
theta=zeros(1,NT);   %相位估计输出
slf=zeros(1,NT);     % LF输出信号
ziLF=zeros(1,max(length(aLF),length(bLF))-1);    %保存LF滤波器状态
ziVCO=zeros(1,max(length(aVCO),length(bVCO))-1); %保存VCO滤波器状态

for n=1:NT
   t=tt(n);  
   xin(n)=sin(wc*t+phi(n));     % PLL输入信号
   xout(n)=cos(wc*t+theta(n));
   e(n)= xin(n)*xout(n);      % 环路滤波器的输入信号

  [slf(n+1),ziLF]=filter(bLF,aLF,e(n),ziLF);
  [theta(n+1),ziVCO]= filter(bVCO,aVCO,slf(n+1),ziVCO);% 通过VCO滤波器，输出相位估计
end

plot(tt,theta,'r', tt,phi,'k'), box off
xlim(tt([1 end]));
xlabel('时间[s]')
ylabel('相位[rad]')
title('锁相环相位跟踪')
legend('实际相位','估计相位')


