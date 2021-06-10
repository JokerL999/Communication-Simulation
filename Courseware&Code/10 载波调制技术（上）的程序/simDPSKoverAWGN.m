% simDPSK.m
clear all;clc;close all
rng default

%% 参数设置
nSym=1e7;                %符号数目
EbN0dB = 0:2:24;        % Eb/N0[dB] 的仿真范围

a=randi([0,1],nSym,1); 
initphase=2*rand*pi; % 初始相位
%initphase=2*rand; % 初始相位
s_denc=mod(cumsum(a),2); 
s_denc=cumsum(a); 
xphase=initphase+s_denc; 
 
xmodsig=exp(1i*pi*xphase); 

%% 仿真
BER=zeros(1,length(EbN0dB)); 
BER_theory =zeros(1,length(EbN0dB));
for i=1:length(EbN0dB)
    ychout=add_awgn_noise(xmodsig,EbN0dB(i)); % 通过AWGN信道
    % 非相干检测
    yphase=angle(ychout) ; 
    ydfdec=diff(yphase)/pi ; 
    dec=(abs(ydfdec)>0.5); 

    % 计算仿真BER
    BER(i)= sum(dec~=a(2:end))/(nSym-1); 
    % 计算理论BER
    BER_theory(i)= 0.5*exp(-10^( EbN0dB(i) /10)); 
end 

%% 结果展示
semilogy(EbN0dB, BER_theory , 'r-' , EbN0dB, BER, ' ko ' ) ; 
ylim([1e-5, 1])
legend ( '理论BER ' , '仿真BER' ); 
xlabel ( 'Eb/N0(dB)'); 
ylabel ( 'BER' ); 
