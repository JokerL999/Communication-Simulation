% MQAM的SER性能
clear all;clc;close all
rng default

%% 参数设置
nSym=1e6;                %符号数目
EbN0dB = 0:2:24;        % Eb/N0[dB] 的仿真范围
arrayofM=[4,16,64,256]; %MQAM的阶数

%% 仿真
SER_theory=zeros(length(arrayofM),length(EbN0dB));
SER_sim=zeros(length(arrayofM),length(EbN0dB));
for i = 1:length(arrayofM)
    M=arrayofM(i);
    k=log2(M); 
    EsN0dB = 10*log10(k)+EbN0dB; %计算Es/N0的dB值
    a=randi([1,M],1,nSym);%生成1~M的符号值
    [s,ref]=mqam_modulator(M,a);

    for j=1:length(EsN0dB)
        r = add_awgn_noise(s,EsN0dB(j));%通过AWGN信道
        acap= mqam_detector(M,r);
        SER_sim(i,j)=sum((a~=acap))/nSym;%计算仿真SER   
        %计算理论SER：性能公式为《Digital Communications》第五版 （4-3-27）
        %《Fundamentals of Communication Systems》第2版（8.7.16）
        SER_theory(i,j) =1-(1-2*(1-1/sqrt(M))*qfn(sqrt(3*log2(M)*10.^(EbN0dB(j)/10)/(M-1))))^2;
    end
end

%% 结果展示
plotColor =['g','r','c','m'];  
legendString = cell(1,length(arrayofM)*2);
for i = 1:length(arrayofM)    
    semilogy(EbN0dB,SER_sim(i,:),[plotColor(i) '*']); hold on;
    semilogy(EbN0dB,SER_theory(i,:),plotColor(i)); 
    legendString{2*i-1}=['仿真 ',num2str(arrayofM(i)),'-QAM'];
    legendString{2*i}=['理论 ',num2str(arrayofM(i)),'-QAM'];
end
hold off;
legend(legendString,'Location','southwest');
xlabel('Eb/N0(dB)');ylabel('SER');
ylim([1e-6 1])
title('MQAM的SER性能');