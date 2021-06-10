clearvars,close all

Tsym=1; %���ų���ʱ��
L=10;   %ÿ�����ŵĲ�����Ŀ
Nsym=20; %���Nsym�����Ҹ�Nsym/2��
fs=L/Tsym;
Tsam=1/fs;

[y,t]=rectFunction(L,Nsym); %Rectangular Pulse
subplot(211)
plot(t,y,'LineWidth',1.5); 
xlabel('ʱ��[s]')
ylabel('����')

[fftVals,freqVals]=FreqDomainAnalysis(y,fs,'double');
subplot(212)
plot(freqVals,abs(fftVals))
xlabel('Ƶ��[Hz]')