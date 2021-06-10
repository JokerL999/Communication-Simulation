% 多径信道PDP和频率相关函数
clearvars;close all;clc;

Ps = [0 -2.9 -5.8 -8.7 -11.6];         %PDP矢量[dB]
p_i = 10.^(Ps/10);                     %转为线性值
Ts=100e-9;                             %采样周期
Fs=1/Ts;                               %采样率
TAUs = [0:length(Ps)-1]*Ts;            %相对时延矢量

subplot(211);
plotObj=stem(TAUs,Ps);
set(plotObj,'basevalue',-14);  %以-14为基准，使stem由下而上的绘制
title('功率时延分布');
xlabel('相对时延 \tau (s)'); ylabel('相对功率[dB]');

subplot(212);
[Yf,f]=SpectrumViewer(p_i,Fs,'twosided',Fs/256);%频率相关函数
plot(f,abs(Yf),'r')
title('频率相关函数'); 
xlabel('频率间隔 \Delta f (Hz)');
ylabel('自相关函数 \rho(\Delta f)');