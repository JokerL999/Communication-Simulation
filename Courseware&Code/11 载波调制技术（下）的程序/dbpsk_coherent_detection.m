% ��ֱ���BPSK���Ƶ���ؼ��
clear all;clc;close all
rng default

%% ��������
N=1e5   ;         %���͵ķ�����Ŀ
EbN0dB = -4:2:10; % �����Eb/N0��dB��Χ
L=16;             %����������
Fc=800;           %��Ƶ
Fs=L*Fc;          %����Ƶ��

EbN0lin = 10.^(EbN0dB/10); 
EsN0dB=10*log10(1)+EbN0dB; 
EsN0lin = 10.^(EsN0dB/10);
SER = zeros(length(EbN0dB),1);

%% �����źŵ����뷢�䲨��
ak = randi([0,1],N,1);       %������������
bk = filter(1,[1 -1],ak,0);  %IIR��ֱ���
bk = mod(bk,2);              %ģ2����
[s_bb,t]= bpsk_mod(bk,L);    %����BPSK����
s = s_bb.*cos(2*pi*Fc*t/Fs); %�ز�����

%% ���ղ��μ��
for i=1:length(EbN0dB)
    Esym=sum(abs(s).^2)/length(s); %�ź�����
    N0= Esym/EsN0lin(i); %���㹦�����ܶ�
    n=sqrt(L*N0/2)*(randn(1,length(s))+1i*randn(1,length(s)));
    r = s + n;%ͨ��AWGN�ŵ�
    
    phaseAmbiguity=pi;     %ģ��Costas�����µ�180����λģ��
    r_bb=r.*cos(2*pi*Fc*t/Fs+phaseAmbiguity);%�ز����
    b_cap=bpsk_demod(r_bb,L);%������ؽ��
    a_cap=filter([1 1],1,b_cap); %FIR��ֽ���
    a_cap= mod(a_cap,2); %ģ2����    
    SER(i) = sum(ak~=a_cap)/N;%SERͳ��  
end
theorySER_DPSK = erfc(sqrt(EbN0lin)).*(1-0.5*erfc(sqrt(EbN0lin)));
theorySER_BPSK = 0.5*erfc(sqrt(EbN0lin));

%% ���չʾ
figure;semilogy(EbN0dB,SER,'k*'); hold on;
semilogy(EbN0dB,theorySER_DPSK,'r-');
semilogy(EbN0dB,theorySER_BPSK,'b-');
title('AWGN�ŵ��²�ֱ���BPSK�źŵ���ؼ������');
xlabel('E_b/N_0 (dB)');ylabel('BER - P_b');
legend('��ؼ�� DBPSK(����)','��ؼ�� DBPSK(���ۣ�','��ͳBPSK')