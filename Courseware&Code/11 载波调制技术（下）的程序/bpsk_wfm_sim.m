% BPSK���η���
clearvars ; clc; close all
rng default

%% ��������
N=1e5   ;         %���͵ķ�����Ŀ
EbN0dB = -4:2:10; % �����Eb/N0��dB��Χ
L=16;             %����������
Fc=800;           %��Ƶ
Fs=L*Fc;          %����Ƶ��

%% �����źŵ����뷢�䲨��
ak = randi([0,1],N,1)>0.5;    %������������
[s_bb,t]= bpsk_mod(ak,L);     %���������ź�
s = s_bb.*cos(2*pi*Fc*t/Fs);  %�ز������ź�

subplot(2,2,1);plot(t,s_bb);%�����ź�
xlabel('t(s)'); ylabel('s_{bb}(t)-baseband');xlim([0,10*L]);
subplot(2,2,2);plot(t,s);   %���䲨��
xlabel('t(s)'); ylabel('s(t)-with carrier');xlim([0,10*L]);
%���������
subplot(2,2,3);plot(real(s_bb),imag(s_bb),'o'); 
xlim([-1.5 1.5]); ylim([-1.5 1.5]); 

%% ���ղ��μ��
EbN0lin = 10.^(EbN0dB/10);
BER = zeros(length(EbN0dB),1); %����BER�洢�ռ�
for i=1:length(EbN0dB)
    Eb=L*sum(abs(s).^2)/length(s); %�ź�����
    N0= Eb/EbN0lin(i); %���������������ܶ�
    n = sqrt(N0/2)*randn(1,length(s));%��������
    
    r = s + n;%ͨ�������ŵ�    
    r_bb = r.*cos(2*pi*Fc*t/Fs);%�ز����
    ak_cap = bpsk_demod(r_bb,L);%������ؽ��
    BER(i) = sum(ak~=ak_cap)/N; %SER/BERͳ��
    
    %�����źŲ���
    subplot(2,2,4);plot(t,r);
    xlabel('t(s)'); ylabel('r(t)');xlim([0,10*L]);
 end
theoreticalBER = 0.5*erfc(sqrt(EbN0lin));%����BER
%% ���չʾ
figure;semilogy(EbN0dB,BER,'k*'); 
hold on;semilogy(EbN0dB,theoreticalBER,'r-');
xlabel('E_b/N_0 (dB)'); ylabel('BER - P_b');
legend('����', '����');grid on;
title(['BPSK���Ƶ�BER']);