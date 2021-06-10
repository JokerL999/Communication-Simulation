% simMPSKoverRice.m
clear all;clc;close all
rng default

%% 参数设置
nSym=1e6;                %符号数目
EbN0dB =-10:2:20;        % Eb/N0[dB] 的仿真范围
K_dB = [3,5,10,20];      %Rician fading的K因子dB矢量
%arrayofM=[4,8,16,32];   %MPSK的阶数
M=16;

%% 仿真
SER_theory=zeros(length(K_dB),length(EbN0dB));
SER_sim=zeros(length(K_dB),length(EbN0dB));

for i = 1:length(K_dB)
%     M=arrayofM(i);
    k=log2(M); 
    EsN0dB = 10*log10(k)+EbN0dB; %计算Es/N0的dB值
    a=randi([1,M],1,nSym);%生成1~M的符号值
    [s,ref]=mpsk_modulator(M,a); 
        
    K = 10.^(K_dB(i)/10); %K factor in linear scale
    g1 = sqrt(K/(2*(K+1))); g2 = sqrt(1/(2*(K+1)));

    for j=1:length(EsN0dB)
        h = (g2*randn(1,nSym)+g1)+1i*(g2*randn(1,nSym)+g1);
        hs=abs(h).*s;
        r = add_awgn_noise(hs,EsN0dB(j));%通过AWGN信道
        y=r./abs(h);
        acap= mpsk_detector(M,y);
        SER_sim(i,j)=sum((a~=acap))/nSym; %计算仿真SER        
        %计算理论SER：性能公式为《Digital Communication over Fading Channels》第2版 （8.114）  
        gamma_s=10^(EsN0dB(j)/10);
        g = sin(pi/M).^2;
        fun = @(x) ((1+K)*sin(x).^2)/((1+K)*sin(x).^2+g*gamma_s)....
            *exp(-K*g*gamma_s./((1+K)*sin(x).^2+g*gamma_s)); 
        SER_theory(i,j) = (1/pi)*integral(fun,0,pi*(M-1)/M); 
    end
end

%% 结果展示
plotColor =['g','r','c','m'];  
legendString = cell(1,length(K_dB)*2);
for i = 1:length(K_dB)    
    semilogy(EbN0dB,SER_sim(i,:),[plotColor(i) '*']); hold on;
    semilogy(EbN0dB,SER_theory(i,:),plotColor(i)); 
    legendString{2*i-1}=['仿真 K=',num2str(K_dB(i))];
    legendString{2*i}=['理论 K=',num2str(K_dB(i))];
end
hold off;
legend(legendString,'Location','southwest');xlabel('Eb/N0(dB)');ylabel('SER');
ylim([1e-3 1])
title('Rice信道下MPSK的SER性能');