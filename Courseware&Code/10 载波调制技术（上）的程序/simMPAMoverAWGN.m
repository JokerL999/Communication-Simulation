% simMPAMoverAWGN：仿真MPAM的BER和SER性能
clearvars;clc;close all
rng default;

%% 参数设置
N=1e6;            %符号数目
EbN0dB = -4:2:24; % Eb/N0[dB] 的仿真范围
arrayofM=[2 4 8 16]; %调制阶数

SER=zeros(length(arrayofM),length(EbN0dB));
BER=zeros(length(arrayofM),length(EbN0dB));
theoreticalSER=zeros(length(arrayofM),length(EbN0dB));

%% 性能仿真
for i = 1:length(arrayofM)
    M=arrayofM(i);
    k=log2(M); %每符号的比特数目
    m=1:1:M; 
    Am=2*m-1-M; % MPAM的星座点
    dataIn=randi([0,1],1,k*N); %发送的信息比特    
    dataInMatrix = reshape(dataIn,length(dataIn)/k,k);  %转成每行k个元素的矩阵
    SymbolIn= bi2de(dataInMatrix)+1;                    %转成整数，即符号
    SymbolIn = reshape(SymbolIn,1,[]);
    
    [s,ref]=mpam_modulator(M,SymbolIn);
    
    EbN0lin = 10.^(EbN0dB/10); 
    EsN0dB = 10*log10(k)+EbN0dB; %EsN0dB calculation
     
    for j=1:length(EsN0dB)        
        y = add_awgn_noise(s,EsN0dB(j));%通过AWGN信道
        
        [SymbolOut]= mpam_detector(M,y);
        SER(i,j)=sum((SymbolIn~=SymbolOut))/N;%计算SER        
        %理论SER：性能公式为《Digital Communications》第五版（4-3-5）
        theoreticalSER(i,j)=2*((M-1)/M)*qfn(sqrt(6*log2(M)/(M^2-1)*10.^(EbN0dB(j)/10)));
        
        SymbolOut = reshape(SymbolOut,[],1)-1;        
        dataOutMatrix = de2bi(SymbolOut,k);
        dataOut = reshape(dataOutMatrix,1,[]);  
        BER(i,j)=sum((dataIn~=dataOut))/(N*k);%计算BER        
    end
end

%% 结果展示  
plotColor =['b','g','r','c'];  % 曲线颜色
legendString = cell(1,length(arrayofM)*2);
 for i=1:length(arrayofM)    
     semilogy(EbN0dB,SER(i,:),[plotColor(i) '*']); hold on;
     semilogy(EbN0dB,theoreticalSER(i,:),plotColor(i)); 
     legendString{2*i-1}=['仿真 ',num2str(arrayofM(i)),'-PAM'];
     legendString{2*i}=['理论 ',num2str(arrayofM(i)),'-PAM'];
 end 
legend(legendString,'Location','southwest');xlabel('Eb/N0(dB)');ylabel('SER');
title('MPAM的SER性能');
ylim([1e-6,1])
hold off

figure;
legendString = cell(1,length(arrayofM));
 for i=1:length(arrayofM)    
     semilogy(EbN0dB,BER(i,:),[plotColor(i) '-*']); hold on;
     legendString{i}=['仿真 ',num2str(arrayofM(i)),'-PAM'];
 end 
hold off
legend(legendString,'Location','southwest');
xlabel('Eb/N0(dB)');ylabel('BER');
ylim([1e-6,1])
title('MPAM的BER性能');