%比较几种带通信号的功率谱密度
clear all;clc;close all
rng default

N=100000;%发送的符号数目
Fc=10; %载频
OF=8;   %过采样因子
Fs = Fc*OF;%采样频率

a = randi([0,1],N,1);       %二进制数据流

[s_bb,t]= bpsk_mod(a,OF); %BPSK基带
s_bpsk = s_bb.*cos(2*pi*Fc*t/Fs);%载波调制后的BPSK
s_qpsk = qpsk_mod(a,Fc,OF); %传统QPSK
s_msk = msk_mod(a,Fc,OF);   %MSK信号

%计算并绘制PSD
figure
plotWelchPSD(s_bpsk,Fs,Fc,'b'); hold on;
plotWelchPSD(s_qpsk,Fs,Fc,'r');
plotWelchPSD(s_msk,Fs,Fc,'k');
legend('BPSK','QPSK','MSK');xlabel('f-f_c'),ylabel('PSD');