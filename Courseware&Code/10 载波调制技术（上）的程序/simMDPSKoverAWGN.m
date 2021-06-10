clc;clearvars;close all;
rng default
%% ��������
N = 1e6; %������Ŀ
EbN0dB = -4:2:16; % Eb/N0[dB] �ķ��淶Χ
arrayofM = [2,4,8,16,32]; %MDPSK�Ľ���

%% ����
SER_sim = zeros(length(arrayofM),length(EbN0dB));
SER_theory = zeros(length(arrayofM),length(EbN0dB));
for i=1:length(arrayofM)
    M=arrayofM(i);
    k=log2(M);
    EsN0dB = EbN0dB + 10*log10(k);
    
    data = randi([0,M-1],1,N-1);  
    
    % ���ɲ�ֵ����ź�
    % phi[k] = phi[k-1] + Dphi[k]
    data_diff = filter(1,[1 -1],data); 
    x=exp(1i*2*pi*data_diff/M);
    
    for j=1:length(EsN0dB)               
        y=add_awgn_noise(x,EsN0dB(j));        
        estPhase = angle(y);
        % Dphi[k] = phi[k] �C phi[k-1]
        est_diffPhase = filter([1 -1],1,estPhase)*M/(2*pi);
        dec = mod(round(est_diffPhase),M); % �������

        SER_sim(i,j) = sum(dec~=data)/(N); %����SER
        %����SER
        gamma_s=10^(EsN0dB(j)/10);
        gamma_b=10^(EbN0dB(j)/10);

        %MDPSK������ܹ�ʽΪ��Digital Communication over Fading Channels 2nd����2�棨8.84��
        g = sin(pi/M).^2;
        fun=@(x)exp(-gamma_s*(1-cos(pi/M)*cos(x)))/(1-cos(pi/M)*cos(x));
        SER_theory(i,j)=sin(pi/M)/(2*pi)*integral(fun,-pi/2,pi/2,'ArrayValued',true);
    end  
end

%% ���չʾ
plotColor=['b','r','g','k','m'];
legendString = cell(1,length(arrayofM)*2);
for i = 1:length(arrayofM)    
    semilogy(EbN0dB,SER_sim(i,:),[plotColor(i) '*']); hold on;
    semilogy(EbN0dB,SER_theory(i,:),plotColor(i)); 
    legendString{2*i-1}=['���� ',num2str(arrayofM(i)),'-DPSK'];
    legendString{2*i}=['���� ',num2str(arrayofM(i)),'-DPSK'];
end
hold off;
legend(legendString,'Location','southwest');xlabel('Eb/N0(dB)');ylabel('SER');
 ylim([1e-6 1])
title('AWGN�ŵ���M-DPSK��SER����');
grid on