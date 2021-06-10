%�Ƚϼ��ִ�ͨ�źŵĹ������ܶ�
clear all;clc;close all
rng default

N=100000;%���͵ķ�����Ŀ
Fc=10; %��Ƶ
OF=8;   %����������
Fs = Fc*OF;%����Ƶ��

a = randi([0,1],N,1);       %������������

[s_bb,t]= bpsk_mod(a,OF); %BPSK����
s_bpsk = s_bb.*cos(2*pi*Fc*t/Fs);%�ز����ƺ��BPSK
s_qpsk = qpsk_mod(a,Fc,OF); %��ͳQPSK
s_msk = msk_mod(a,Fc,OF);   %MSK�ź�

%���㲢����PSD
figure
plotWelchPSD(s_bpsk,Fs,Fc,'b'); hold on;
plotWelchPSD(s_qpsk,Fs,Fc,'r');
plotWelchPSD(s_msk,Fs,Fc,'k');
legend('BPSK','QPSK','MSK');xlabel('f-f_c'),ylabel('PSD');