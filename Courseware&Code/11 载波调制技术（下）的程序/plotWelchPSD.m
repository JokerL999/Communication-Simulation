function [Pss,f]=plotWelchPSD(SIGNAL,Fs,Fc,COLOR)
% ʹ��Welch���Ʒ������ز������źŵĹ������ܶ�PSD
% SIGNAL - �ź�ʸ��
% Fs - ����Ƶ��
% Fc - ��Ƶ
% COLOR - ���Ƶ���ɫ
ns = max(size(SIGNAL));
na = 16;%averaging factor to plot averaged welch spectrum
w = hanning(floor(ns/na));%Hanning windo%Welch PSD estimate with Hanning window and no overlap
[Pss,f]=pwelch(SIGNAL,w,0,[],Fs,'twosided');
indices = find(f>=Fc & f<4*Fc); %To plot PSD from Fc to 4*Fc
Pss=Pss(indices)/Pss(indices(1)); %normalized psd w.r.t Fc
plot(f(indices)-Fc,10*log10(Pss),COLOR);%normalize frequency axis