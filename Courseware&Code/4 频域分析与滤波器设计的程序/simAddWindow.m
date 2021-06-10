%泄露现象与汉宁加窗
clearvars;close all;

Ts = 0.01;
Fs = 1/Ts;
%% 原始信号
t = 0:Ts:1;
xt = sin(2*pi*5*t) + sin(2*pi*10*t);   %信号采样
[Xf, f] = SpectrumViewer(xt, Fs);      %频谱分析

subplot(221)
plot(t, xt);xlabel('t');ylabel('幅度');title('原时域信号')
subplot(223)
plot(f, abs(Xf));xlabel('f');ylabel('幅度谱')
xlim([0 100]);ylim([0 1])
title('原时域信号频谱')

%% 加汉宁窗
win = hann(length(t));
xt1= xt.*win';                      % 加汉宁窗
[X1, f1] = SpectrumViewer(xt1, Fs); % 频谱分析
Xf1=2*X1;                           % 加窗后的幅度修正

subplot(222)
plot(t, xt1);xlabel('t');ylabel('时域幅度')
title('加窗信号')
subplot(224)
plot(f1, abs(Xf1))
xlabel('f');ylabel('幅度谱');title('加窗信号频谱')
xlim([0 100]);ylim([0 1])