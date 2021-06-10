clearvars,close all

Tsym=1; %符号时间
L=10;  %过采样因子（每个符号的样点数目）
Nsym = 20; %滤波器跨度（以符号为单位，持续时间,-Nsym/2~Nsym/2）
Fs=L/Tsym; %采样频率

[p,t]=sincFunction(L,Tsym,Nsym); %Sinc Pulse
subplot(1,2,1);
t=t*Tsym; 
plot(t,p); 
title('Sinc脉冲');    
grid on
[fftVals,freqVals]=FreqDomainAnalysis(p,Fs,'double'); 
subplot(1,2,2); 
plot(freqVals,abs(fftVals))
grid on

