clear all; clc; close all

%% �������
N=1e5; %���ͱ�����Ŀ
EbN0dB = 0:2:30; % Eb/N0 ��dBֵ��Χ
M=2; %2-PSK
h_c=[0.04 -0.05 0.07 -0.21 -0.5 0.72 0.36 0.21 0.03 0.07];%Channel A
nTaps = 31; %�������ĳ�ͷ��Ŀ

%% ����
SER_zf=zeros(length(EbN0dB),1);
d= randi([0,1],1,N); 
ref=cos(((M:-1:1)-1)/M*2*pi); %BPSK����
s = ref(d+1); %BPSK����
x = conv(s,h_c); %ͨ�������ŵ�

for i=1:length(EbN0dB)
  r=add_awgn_noise(x,EbN0dB(i));%����AWGN���� r = x+n

  [h_zf,error,optDelay]=zf_equalizer(h_c,nTaps);% ZF������
  y_zf=conv(h_zf,r);                            %�����ź�ͨ��������
  y_zf = y_zf(optDelay+1:optDelay+N);           %�����ʱ��λ���Ժ�ȡ����

  dcap_zf=(y_zf>=0);%Ӳ��
  SER_zf(i)=sum((d~=dcap_zf))/N;%����ֵ
end
theoreticalSER = 0.5*erfc(sqrt(10.^(EbN0dB/10)));%����AWGN�ŵ��µ�BPSK����SER

%% ���չʾ
figure; semilogy(EbN0dB,SER_zf,'g'); hold on;
semilogy(EbN0dB,theoreticalSER,'k');
title('�����ŵ���BPSK���������');
xlabel('E_b/N_0 (dB)');ylabel('SER- P_s');
legend('ZF������','����AWGN�ŵ�');grid on;
xlim([0,10])

[H_c,W]=freqz(h_c);%�ŵ�����
figure;
subplot(1,2,1);
stem(h_c);%�ŵ���ʱ��弤��Ӧ
subplot(1,2,2);
plot(W,20*log10(abs(H_c)/max(abs(H_c))));%�ŵ�Ƶ����Ӧ