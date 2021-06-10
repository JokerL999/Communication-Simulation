% MQAM��SER����
clear all;clc;close all
rng default

%% ��������
nSym=1e6;                %������Ŀ
EbN0dB = 0:2:24;        % Eb/N0[dB] �ķ��淶Χ
arrayofM=[4,16,64,256]; %MQAM�Ľ���

%% ����
SER_theory=zeros(length(arrayofM),length(EbN0dB));
SER_sim=zeros(length(arrayofM),length(EbN0dB));
for i = 1:length(arrayofM)
    M=arrayofM(i);
    k=log2(M); 
    EsN0dB = 10*log10(k)+EbN0dB; %����Es/N0��dBֵ
    a=randi([1,M],1,nSym);%����1~M�ķ���ֵ
    [s,ref]=mqam_modulator(M,a);

    for j=1:length(EsN0dB)
        r = add_awgn_noise(s,EsN0dB(j));%ͨ��AWGN�ŵ�
        acap= mqam_detector(M,r);
        SER_sim(i,j)=sum((a~=acap))/nSym;%�������SER   
        %��������SER�����ܹ�ʽΪ��Digital Communications������� ��4-3-27��
        %��Fundamentals of Communication Systems����2�棨8.7.16��
        SER_theory(i,j) =1-(1-2*(1-1/sqrt(M))*qfn(sqrt(3*log2(M)*10.^(EbN0dB(j)/10)/(M-1))))^2;
    end
end

%% ���չʾ
plotColor =['g','r','c','m'];  
legendString = cell(1,length(arrayofM)*2);
for i = 1:length(arrayofM)    
    semilogy(EbN0dB,SER_sim(i,:),[plotColor(i) '*']); hold on;
    semilogy(EbN0dB,SER_theory(i,:),plotColor(i)); 
    legendString{2*i-1}=['���� ',num2str(arrayofM(i)),'-QAM'];
    legendString{2*i}=['���� ',num2str(arrayofM(i)),'-QAM'];
end
hold off;
legend(legendString,'Location','southwest');
xlabel('Eb/N0(dB)');ylabel('SER');
ylim([1e-6 1])
title('MQAM��SER����');