% simDPSK.m
clear all;clc;close all
rng default

%% ��������
nSym=1e7;                %������Ŀ
EbN0dB = 0:2:24;        % Eb/N0[dB] �ķ��淶Χ

a=randi([0,1],nSym,1); 
initphase=2*rand*pi; % ��ʼ��λ
%initphase=2*rand; % ��ʼ��λ
s_denc=mod(cumsum(a),2); 
s_denc=cumsum(a); 
xphase=initphase+s_denc; 
 
xmodsig=exp(1i*pi*xphase); 

%% ����
BER=zeros(1,length(EbN0dB)); 
BER_theory =zeros(1,length(EbN0dB));
for i=1:length(EbN0dB)
    ychout=add_awgn_noise(xmodsig,EbN0dB(i)); % ͨ��AWGN�ŵ�
    % ����ɼ��
    yphase=angle(ychout) ; 
    ydfdec=diff(yphase)/pi ; 
    dec=(abs(ydfdec)>0.5); 

    % �������BER
    BER(i)= sum(dec~=a(2:end))/(nSym-1); 
    % ��������BER
    BER_theory(i)= 0.5*exp(-10^( EbN0dB(i) /10)); 
end 

%% ���չʾ
semilogy(EbN0dB, BER_theory , 'r-' , EbN0dB, BER, ' ko ' ) ; 
ylim([1e-5, 1])
legend ( '����BER ' , '����BER' ); 
xlabel ( 'Eb/N0(dB)'); 
ylabel ( 'BER' ); 
