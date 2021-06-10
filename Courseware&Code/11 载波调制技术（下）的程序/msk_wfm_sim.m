%MSK���η���
clear all;clc;close all
rng default

%% ��������
N=1e5   ;         %���͵ķ�����Ŀ
EbN0dB = -4:2:10; %�����Eb/N0��dB��Χ
fc=800;           %��Ƶ[Hz]
OF =32;            %���������� fs=OF*fc

EbN0lin = 10.^(EbN0dB/10); 
BER = zeros(length(EbN0dB),1); 

a = randi([0,1],N,1);       %������������
[s,t] = msk_mod(a,fc,OF);   %MSK����

for i=1:length(EbN0dB),
    Eb=OF*sum(abs(s).^2)/(length(s)); %�����ź�����
    N0= Eb/EbN0lin(i); %�����������ܶ�
    n = sqrt(N0/2)*(randn(1,length(s)));%��������
    r = s + n;
    a_cap = msk_demod(r,N,fc,OF);
    BER(i) = sum(a~=a_cap)/N;%ͳ��
end
theoreticalBER = 0.5*erfc(sqrt(EbN0lin));%����BER

%% ���չʾ
figure;semilogy(EbN0dB,BER,'k*','LineWidth',1.5); hold on;%simulated BER
semilogy(EbN0dB,theoreticalBER,'r-','LineWidth',1.5);%theoretical BER
set(gca,'XLim',[-4 12]);set(gca,'YLim',[1E-6 1E0]);set(gca,'XTick',-4:2:12);
title('MSK���Ƶ�����');
xlabel('E_b/N_0 (dB)');ylabel('BER - P_b');
legend('����', '����');grid on;