%��Ƶ�ʷ����ؽ�ʱ���ź�
clearvars;close all;

Ts = 0.01;
Fs = 1/Ts;
%% ԭʼ�ź�
t = 0:Ts:5;
xt = sin(2*pi*5*t) + sin(2*pi*10*t);   %�źŲ���
subplot(2,1,1); plot(t,xt); xlabel('t');ylabel('����');title('ԭʱ���ź�')

[X, ~] = SpectrumViewer(xt, Fs, 'twosided');

N=length(X);
x_recon = N*ifft(ifftshift(X),N); %�źŻָ�
tt = [0:1:length(x_recon)-1]/Fs;   %ʱ��̶�
subplot(2,1,2); plot(tt,x_recon);  title('�ؽ��ź�')