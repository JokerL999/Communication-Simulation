%演示 信号经过汉明编码和BPSK调制，在 AWGN下的性能
clearvars; clc;close all
nBits =10^7; %信源的比特数目
EbN0dB = -2:1:12; % Eb/N0 的仿真范围
MOD_TYPE='PSK'; %Modulation类型 
M=2;           %BPSK的调制阶数

G=[ 1 0 0 0 1 1 0; %(7,4) 汉明码的生成矩阵
    0 1 0 0 1 0 1;
    0 0 1 0 0 1 1;
    0 0 0 1 1 1 1];

[k,n] = size(G); 
H = gen2parmat(G); % 产生校验矩阵
syndromeTable = getSyndromeTable(G); % 校验子译码表

m=de2bi(0:1:2^k-1,'left-msb');% 产生所有可能信息序列
C=mod(m*G,2); % 产生码本

%考虑编码开销的EsN0dB
EsN0dB = EbN0dB + 10*log10(log2(M)) + 10*log10(k/n); 
BER_Hamming_Hard = zeros(1,length(EbN0dB));%硬判BER结果保存空间
BER_Hamming_Soft = zeros(1,length(EbN0dB));%软判BER结果保存空间
    
for i=1:length(EsN0dB)
  %---- 发射机 - 分组编码, BPSK 调制-------
  x =rand(1,nBits) > 0.5; 
  
  %若信息位长度不是整数倍k，补零
  if mod(nBits,k)>0
      x =[x zeros(1,k-mod(nBits,k))];
  end
  
  m = reshape(x,k,length(x)/k).'; %消息分组
  cBlocks = mod(m*G,2);           %生成码字
  c= cBlocks.'; 
  c = c(:).';   %将码字组成信号流
  y =complex(2*c-1);    %BPSK
  
  %---------AWGN信道 --------------------
  r  = add_awgn_noise(y,EsN0dB(i));
  
  %--------接收机：硬判译码---------
  rHard = (real(r)>=0);%BPSK硬判解调
  rHardBlks=reshape(rHard,n,length(rHard)/n).';%长度为n的分组
  syndrome = mod(rHardBlks*H.',2); %计算校验子
  syndrome = bi2de(syndrome,'left-msb');
  errorEst=cell2mat(syndromeTable(syndrome+1,2));%找到错误位置     
  cHardBlks = mod(rHardBlks-errorEst,2);%作为硬判译码输出
  mHardBlks = cHardBlks(:,1:k);%去掉码字中的校验比特
  %形成比特流
  xHardBlks = mHardBlks.'; 
  xHard=xHardBlks(:).';
  BER_Hamming_Hard(i) = sum(sum(x~=xHard))/numel(xHard);%计算硬判BER
  
  %--------接收机：软判译码 -------
  rBlks = reshape(real(r),n,length(r)/n).';%长度为n的分组
  %计算相关值，并找出相关值最大的码字
  [maxCorrVal,maxCorrIndex]=max((2*C-1)*rBlks.');
  cSoftBlks = C(maxCorrIndex,:);%作为软判译码输出
  mSoftBlks = cSoftBlks(:,1:k);%去掉码字中的校验比特
  %形成比特流
  xSoftBlks = mSoftBlks.'; 
  xSoft=xSoftBlks(:).';
  BER_Hamming_Soft(i) = sum(sum(x~=xSoft))/numel(xSoft);%计算软判BER
end
BER_uncoded_theory=0.5*erfc(sqrt(10.^(EbN0dB/10)));%BPSK的理论BER(无编码)
figure;
semilogy(EbN0dB,BER_Hamming_Hard,'r*-'); hold on;
semilogy(EbN0dB,BER_Hamming_Soft,'bo-'); 
semilogy(EbN0dB,BER_uncoded_theory,'k-'); grid on;
legend('(7,4) 汉明码 (硬判)','(7,4) 汉明码 (软判)',...
    '无编码 BPSK (理论)');
xlabel('Eb/N0(dB)');ylabel('误码率BER');
title('AWGN信道下BPSK调制的BER性能');
ylim([1e-5,1])