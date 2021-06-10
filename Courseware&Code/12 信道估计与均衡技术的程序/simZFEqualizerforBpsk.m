clear all; clc; close all

%% 输入参数
N=1e5; %发送比特数目
EbN0dB = 0:2:30; % Eb/N0 的dB值范围
M=2; %2-PSK
h_c=[0.04 -0.05 0.07 -0.21 -0.5 0.72 0.36 0.21 0.03 0.07];%Channel A
nTaps = 31; %均衡器的抽头数目

%% 仿真
SER_zf=zeros(length(EbN0dB),1);
d= randi([0,1],1,N); 
ref=cos(((M:-1:1)-1)/M*2*pi); %BPSK星座
s = ref(d+1); %BPSK调制
x = conv(s,h_c); %通过带限信道

for i=1:length(EbN0dB)
  r=add_awgn_noise(x,EbN0dB(i));%加入AWGN噪声 r = x+n

  [h_zf,error,optDelay]=zf_equalizer(h_c,nTaps);% ZF均衡器
  y_zf=conv(h_zf,r);                            %接收信号通过均衡器
  y_zf = y_zf(optDelay+1:optDelay+N);           %从最佳时延位置以后取数据

  dcap_zf=(y_zf>=0);%硬判
  SER_zf(i)=sum((d~=dcap_zf))/N;%仿真值
end
theoreticalSER = 0.5*erfc(sqrt(10.^(EbN0dB/10)));%理想AWGN信道下的BPSK理论SER

%% 结果展示
figure; semilogy(EbN0dB,SER_zf,'g'); hold on;
semilogy(EbN0dB,theoreticalSER,'k');
title('带限信道下BPSK的误符号率');
xlabel('E_b/N_0 (dB)');ylabel('SER- P_s');
legend('ZF均衡器','理想AWGN信道');grid on;
xlim([0,10])

[H_c,W]=freqz(h_c);%信道特征
figure;
subplot(1,2,1);
stem(h_c);%信道的时域冲激响应
subplot(1,2,2);
plot(W,20*log10(abs(H_c)/max(abs(H_c))));%信道频域响应