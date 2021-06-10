%从频率分量重建时域信号
clearvars;close all;

Ts = 0.01;
Fs = 1/Ts;
%% 原始信号
t = 0:Ts:5;
xt = sin(2*pi*5*t) + sin(2*pi*10*t);   %信号采样
subplot(2,1,1); plot(t,xt); xlabel('t');ylabel('幅度');title('原时域信号')

[X, ~] = SpectrumViewer(xt, Fs, 'twosided');

N=length(X);
x_recon = N*ifft(ifftshift(X),N); %信号恢复
tt = [0:1:length(x_recon)-1]/Fs;   %时间刻度
subplot(2,1,2); plot(tt,x_recon);  title('重建信号')