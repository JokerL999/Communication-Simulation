% simMPSKoverRayleigh.m
clear all;clc;close all
rng default

%% ��������
nSym=1e6;                %������Ŀ
EbN0dB =-10:2:20;        % Eb/N0[dB] �ķ��淶Χ
arrayofM=[4,8,16,32];   %MPSK�Ľ���

%% ����
SER_theory=zeros(length(arrayofM),length(EbN0dB));
SER_sim=zeros(length(arrayofM),length(EbN0dB));

for i = 1:length(arrayofM)
    M=arrayofM(i);
    k=log2(M); 
    EsN0dB = 10*log10(k)+EbN0dB; %����Es/N0��dBֵ
    a=randi([1,M],1,nSym);%����1~M�ķ���ֵ
    [s,ref]=mpsk_modulator(M,a);

    for j=1:length(EsN0dB)
        h=1/sqrt(2)*(randn(1,nSym)+1i*randn(1,nSym));%�����ŵ�
        hs=abs(h).*s;
        r = add_awgn_noise(hs,EsN0dB(j));%ͨ��AWGN�ŵ�
        y=r./abs(h);
        acap= mpsk_detector(M,y);
        SER_sim(i,j)=sum((a~=acap))/nSym; %�������SER        
        %��������SER�����ܹ�ʽΪ��Digital Communication over Fading Channels����2�� ��8.113��  
        g = sin(pi/M).^2;
        temp=sqrt(g*10^(EsN0dB(j)/10)/(1+g*10^(EsN0dB(j)/10)));
        SER_theory(i,j)=(M-1)/M*(1-temp*M/((M-1)*pi)*(pi/2+atan(temp*cot(pi/M))));
    end
end

%% ���չʾ
plotColor =['g','r','c','m'];  
legendString = cell(1,length(arrayofM)*2);
for i = 1:length(arrayofM)    
    semilogy(EbN0dB,SER_sim(i,:),[plotColor(i) '*']); hold on;
    semilogy(EbN0dB,SER_theory(i,:),plotColor(i)); 
    legendString{2*i-1}=['���� ',num2str(arrayofM(i)),'-PSK'];
    legendString{2*i}=['���� ',num2str(arrayofM(i)),'-PSK'];
end
hold off;
legend(legendString,'Location','southwest');xlabel('Eb/N0(dB)');ylabel('SER');
ylim([1e-3 1])
title('Rayleigh�ŵ���MPSK��SER����');