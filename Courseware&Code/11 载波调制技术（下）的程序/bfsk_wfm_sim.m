%BFSK波形仿真
clear all;clc;close all
rng default

%% 参数设置
N=100000;         %发送比特数目,
EbN0dB = -4:2:10; %仿真的Eb/N0的dB范围
Fc = 400;         %载频
fsk_type = 'COHERENT'; %COHERENT/NONCOHERENT FSK generation at Tx
h = 1;            %调制指数，对相干FSK，h最小为0.5或0.5的倍数
                  %         对非相干FSK，h最小为1或为1的倍数
L = 40;           %过采样因子
Fs = 8*Fc;        %采样频率
Tb = L/Fs;        %比特周期
Fd = h/Tb;        %频率偏移

EbN0lin = 10.^(EbN0dB/10);
BER_coherent = zeros(length(EbN0dB),1); 
BER_nonCoherent = BER_coherent;

%% 仿真
a = randi([0,1],1,N);       %二进制数据流
[s,t,phase]=bfsk_mod(a,Fc,Fd,L,Fs,fsk_type); %BFSK调制

for i=1:length(EbN0dB)
  Eb=L*sum(abs(s).^2)/(length(s)); %计算每比特信号能量
  N0= Eb/EbN0lin(i); %噪声功率谱密度
  n = sqrt(N0/2)*(randn(1,length(s)));%生成噪声
  r = s + n;

  if strcmpi(fsk_type,'COHERENT')
    a_cap1 =  bfsk_coherent_demod(r,Fc,Fd,L,Fs,phase);%相干检测
    a_cap2 =  bfsk_noncoherent_demod(r,Fc,Fd,L,Fs);%非相干检测
    BER_coherent(i) = sum(a~=a_cap1)/N;%相干BER统计
    BER_nonCoherent(i) = sum(a~=a_cap2)/N;%非相干BER统计
  end
  if strcmpi(fsk_type,'NONCOHERENT')
     a_cap2 =  bfsk_noncoherent_demod(r,Fc,Fd,L,Fs);%非相干检测
    BER_nonCoherent(i) = sum(a~=a_cap2)/N;%非相干BER统计
  end 
end
coherent = 0.5*erfc(sqrt(EbN0lin/2));%相干检测理论BER
nonCoherent = 0.5*exp(-EbN0lin/2);   %非相干检测理论BER

%% 结果展示
figure; 
if strcmpi(fsk_type,'COHERENT')
  semilogy(EbN0dB,BER_coherent,'k*'); hold on; 
  semilogy(EbN0dB,BER_nonCoherent,'m*');
  semilogy(EbN0dB,coherent,'r-');
  semilogy(EbN0dB,nonCoherent,'b-');
  title('相干BFSK调制的性能');
  legend('仿真相干解调','仿真非相干解调','理论相干解调','理论非相干解调');
end
if strcmpi(fsk_type,'NONCOHERENT'),
  semilogy(EbN0dB,BER_nonCoherent,'m*'); hold on;
  semilogy(EbN0dB,nonCoherent,'b-');
  title('非相干BFSK调制的性能');
  legend('仿真非相干解调','理论非相干解调');
end
xlabel('E_b/N_0 (dB)');ylabel('BER - P_b');