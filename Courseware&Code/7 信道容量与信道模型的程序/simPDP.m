% �ྶ�ŵ�PDP��Ƶ����غ���
clearvars;close all;clc;

Ps = [0 -2.9 -5.8 -8.7 -11.6];         %PDPʸ��[dB]
p_i = 10.^(Ps/10);                     %תΪ����ֵ
Ts=100e-9;                             %��������
Fs=1/Ts;                               %������
TAUs = [0:length(Ps)-1]*Ts;            %���ʱ��ʸ��

subplot(211);
plotObj=stem(TAUs,Ps);
set(plotObj,'basevalue',-14);  %��-14Ϊ��׼��ʹstem���¶��ϵĻ���
title('����ʱ�ӷֲ�');
xlabel('���ʱ�� \tau (s)'); ylabel('��Թ���[dB]');

subplot(212);
[Yf,f]=SpectrumViewer(p_i,Fs,'twosided',Fs/256);%Ƶ����غ���
plot(f,abs(Yf),'r')
title('Ƶ����غ���'); 
xlabel('Ƶ�ʼ�� \Delta f (Hz)');
ylabel('����غ��� \rho(\Delta f)');