clearvars,close all

Tsym=1; %符号持续时间
L=10;   %每个符号的采样数目
Nsym=20; %输出Nsym，左右各Nsym/2个
fs=L/Tsym;
Tsam=1/fs;

[y,t]=rectFunction(L,Nsym); %Rectangular Pulse
subplot(211)
plot(t,y,'LineWidth',1.5); 
xlabel('时间[s]')
ylabel('幅度')

[fftVals,freqVals]=FreqDomainAnalysis(y,fs,'double');
subplot(212)
plot(freqVals,abs(fftVals))
xlabel('频率[Hz]')