function [Pss,f]=plotWelchPSD(SIGNAL,Fs,Fc,COLOR)
% 使用Welch估计法计算载波调制信号的功率谱密度PSD
% SIGNAL - 信号矢量
% Fs - 采样频率
% Fc - 载频
% COLOR - 绘制的颜色
ns = max(size(SIGNAL));
na = 16;%averaging factor to plot averaged welch spectrum
w = hanning(floor(ns/na));%Hanning windo%Welch PSD estimate with Hanning window and no overlap
[Pss,f]=pwelch(SIGNAL,w,0,[],Fs,'twosided');
indices = find(f>=Fc & f<4*Fc); %To plot PSD from Fc to 4*Fc
Pss=Pss(indices)/Pss(indices(1)); %normalized psd w.r.t Fc
plot(f(indices)-Fc,10*log10(Pss),COLOR);%normalize frequency axis