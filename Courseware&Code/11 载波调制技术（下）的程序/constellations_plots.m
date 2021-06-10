%��������
clear all;clc;close all
rng default

%% ��������
N=1000;%���͵ķ�����Ŀ, �����㹻����
fc=10; %��Ƶ
L=8;   %����������

a = randi([0,1],N,1);       %������������

%% ʹ�� QPSK,OQPSK �� MSK �����ź�
[s_qpsk,t_qpsk,I_qpsk,Q_qpsk]=qpsk_mod(a,fc,L);
[s_oqpsk,t_oqpsk,I_oqpsk,Q_oqpsk]=oqpsk_mod(a,fc,L);
[s_msk,t_msk,I_msk,Q_msk] = msk_mod(a,fc,L);

%�����������˲���
alpha = 0.3; % �������˲���alpha����
Nsym = 10;   % �˲����ķ��ſ��
rcPulse = raisedCosineFunction(alpha,L,Nsym);%�������˲�������

%��ͬ�����źŵ�I·��Q·�ź�ͨ�������˲���
iRC_qpsk = conv(I_qpsk,rcPulse,'same');  %�����˲����I·QPSK�ź�
qRC_qpsk = conv(Q_qpsk,rcPulse,'same');  %�����˲����Q·QPSK�ź�
iRC_oqpsk = conv(I_oqpsk,rcPulse,'same');%�����˲����I·OQPSK�ź�
qRC_oqpsk = conv(Q_oqpsk,rcPulse,'same');%�����˲����Q·OQPSK�ź�

%% ������
subplot(1,3,1);plot(iRC_qpsk,qRC_qpsk); %QPSK����
title('QPSK, RC \alpha=0.3');xlabel('I(t)');ylabel('Q(t)');
subplot(1,3,2);plot(iRC_oqpsk,qRC_oqpsk); %OQPSK����
title('O-QPSK, RC \alpha=0.3');xlabel('I(t)');ylabel('Q(t)');
subplot(1,3,3);plot(I_msk(20:end-20),Q_msk(20:end-20)); %MSK�ź�����
title('MSK');xlabel('I(t)');ylabel('Q(t)');