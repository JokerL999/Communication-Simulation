clearvars,close all

Tsym=1; %����ʱ��
L=10;  %���������ӣ�ÿ�����ŵ�������Ŀ��
Nsym = 20; %�˲�����ȣ��Է���Ϊ��λ������ʱ��,-Nsym/2~Nsym/2��
Fs=L/Tsym; %����Ƶ��

[p,t]=sincFunction(L,Tsym,Nsym); %Sinc Pulse
subplot(1,2,1);
t=t*Tsym; 
plot(t,p); 
title('Sinc����');    
grid on
[fftVals,freqVals]=FreqDomainAnalysis(p,Fs,'double'); 
subplot(1,2,2); 
plot(freqVals,abs(fftVals))
grid on

