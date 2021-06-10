% simMPAMoverAWGN������MPAM��BER��SER����
clearvars;clc;close all
rng default;

%% ��������
N=1e6;            %������Ŀ
EbN0dB = -4:2:24; % Eb/N0[dB] �ķ��淶Χ
arrayofM=[2 4 8 16]; %���ƽ���

SER=zeros(length(arrayofM),length(EbN0dB));
BER=zeros(length(arrayofM),length(EbN0dB));
theoreticalSER=zeros(length(arrayofM),length(EbN0dB));

%% ���ܷ���
for i = 1:length(arrayofM)
    M=arrayofM(i);
    k=log2(M); %ÿ���ŵı�����Ŀ
    m=1:1:M; 
    Am=2*m-1-M; % MPAM��������
    dataIn=randi([0,1],1,k*N); %���͵���Ϣ����    
    dataInMatrix = reshape(dataIn,length(dataIn)/k,k);  %ת��ÿ��k��Ԫ�صľ���
    SymbolIn= bi2de(dataInMatrix)+1;                    %ת��������������
    SymbolIn = reshape(SymbolIn,1,[]);
    
    [s,ref]=mpam_modulator(M,SymbolIn);
    
    EbN0lin = 10.^(EbN0dB/10); 
    EsN0dB = 10*log10(k)+EbN0dB; %EsN0dB calculation
     
    for j=1:length(EsN0dB)        
        y = add_awgn_noise(s,EsN0dB(j));%ͨ��AWGN�ŵ�
        
        [SymbolOut]= mpam_detector(M,y);
        SER(i,j)=sum((SymbolIn~=SymbolOut))/N;%����SER        
        %����SER�����ܹ�ʽΪ��Digital Communications������棨4-3-5��
        theoreticalSER(i,j)=2*((M-1)/M)*qfn(sqrt(6*log2(M)/(M^2-1)*10.^(EbN0dB(j)/10)));
        
        SymbolOut = reshape(SymbolOut,[],1)-1;        
        dataOutMatrix = de2bi(SymbolOut,k);
        dataOut = reshape(dataOutMatrix,1,[]);  
        BER(i,j)=sum((dataIn~=dataOut))/(N*k);%����BER        
    end
end

%% ���չʾ  
plotColor =['b','g','r','c'];  % ������ɫ
legendString = cell(1,length(arrayofM)*2);
 for i=1:length(arrayofM)    
     semilogy(EbN0dB,SER(i,:),[plotColor(i) '*']); hold on;
     semilogy(EbN0dB,theoreticalSER(i,:),plotColor(i)); 
     legendString{2*i-1}=['���� ',num2str(arrayofM(i)),'-PAM'];
     legendString{2*i}=['���� ',num2str(arrayofM(i)),'-PAM'];
 end 
legend(legendString,'Location','southwest');xlabel('Eb/N0(dB)');ylabel('SER');
title('MPAM��SER����');
ylim([1e-6,1])
hold off

figure;
legendString = cell(1,length(arrayofM));
 for i=1:length(arrayofM)    
     semilogy(EbN0dB,BER(i,:),[plotColor(i) '-*']); hold on;
     legendString{i}=['���� ',num2str(arrayofM(i)),'-PAM'];
 end 
hold off
legend(legendString,'Location','southwest');
xlabel('Eb/N0(dB)');ylabel('BER');
ylim([1e-6,1])
title('MPAM��BER����');