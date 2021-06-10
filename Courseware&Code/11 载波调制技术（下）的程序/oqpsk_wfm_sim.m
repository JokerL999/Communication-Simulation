%OQPSK���η���
clear all;clc;close all
rng default

%% ��������
N=1e5   ;         %���͵ķ�����Ŀ
EbN0dB = -4:2:10; %�����Eb/N0��dB��Χ
fc=100;           %��Ƶ[Hz]
OF =8;            %���������� fs=OF*fc

EbN0lin = 10.^(EbN0dB/10); 
BER = zeros(length(EbN0dB),1); 

a = randi([0,1],N,1);       %������������
[s,t] = oqpsk_mod(a,fc,OF); %OQPSK ����

for i=1:length(EbN0dB)  
    Eb=OF*sum(abs(s).^2)/(length(s)); %�����ź�����
    N0= Eb/EbN0lin(i); %����������
    n = sqrt(N0/2)*(randn(1,length(s)));%��������
    r = s + n;                     %ͨ��AWGN�ŵ�
    a_cap = oqpsk_demod(r,N,fc,OF); %QPSK���
    BER(i) = sum(a~=a_cap)/N;  %BERͳ��
end
theoreticalBER = 0.5*erfc(sqrt(EbN0lin));%����BER

%% ���չʾ
figure;semilogy(EbN0dB,BER,'k*','LineWidth',1.5); %simulated BER
hold on; semilogy(EbN0dB,theoreticalBER,'r-','LineWidth',1.5);
title('OQPSK��������');
xlabel('E_b/N_0 (dB)');ylabel('BER - P_b');
legend('����', '����');grid on;