%��ʾ �źž������������BPSK���ƣ��� AWGN�µ�����
clearvars; clc;close all
nBits =10^7; %��Դ�ı�����Ŀ
EbN0dB = -2:1:12; % Eb/N0 �ķ��淶Χ
MOD_TYPE='PSK'; %Modulation���� 
M=2;           %BPSK�ĵ��ƽ���

G=[ 1 0 0 0 1 1 0; %(7,4) ����������ɾ���
    0 1 0 0 1 0 1;
    0 0 1 0 0 1 1;
    0 0 0 1 1 1 1];

[k,n] = size(G); 
H = gen2parmat(G); % ����У�����
syndromeTable = getSyndromeTable(G); % У���������

m=de2bi(0:1:2^k-1,'left-msb');% �������п�����Ϣ����
C=mod(m*G,2); % �����뱾

%���Ǳ��뿪����EsN0dB
EsN0dB = EbN0dB + 10*log10(log2(M)) + 10*log10(k/n); 
BER_Hamming_Hard = zeros(1,length(EbN0dB));%Ӳ��BER�������ռ�
BER_Hamming_Soft = zeros(1,length(EbN0dB));%����BER�������ռ�
    
for i=1:length(EsN0dB)
  %---- ����� - �������, BPSK ����-------
  x =rand(1,nBits) > 0.5; 
  
  %����Ϣλ���Ȳ���������k������
  if mod(nBits,k)>0
      x =[x zeros(1,k-mod(nBits,k))];
  end
  
  m = reshape(x,k,length(x)/k).'; %��Ϣ����
  cBlocks = mod(m*G,2);           %��������
  c= cBlocks.'; 
  c = c(:).';   %����������ź���
  y =complex(2*c-1);    %BPSK
  
  %---------AWGN�ŵ� --------------------
  r  = add_awgn_noise(y,EsN0dB(i));
  
  %--------���ջ���Ӳ������---------
  rHard = (real(r)>=0);%BPSKӲ�н��
  rHardBlks=reshape(rHard,n,length(rHard)/n).';%����Ϊn�ķ���
  syndrome = mod(rHardBlks*H.',2); %����У����
  syndrome = bi2de(syndrome,'left-msb');
  errorEst=cell2mat(syndromeTable(syndrome+1,2));%�ҵ�����λ��     
  cHardBlks = mod(rHardBlks-errorEst,2);%��ΪӲ���������
  mHardBlks = cHardBlks(:,1:k);%ȥ�������е�У�����
  %�γɱ�����
  xHardBlks = mHardBlks.'; 
  xHard=xHardBlks(:).';
  BER_Hamming_Hard(i) = sum(sum(x~=xHard))/numel(xHard);%����Ӳ��BER
  
  %--------���ջ����������� -------
  rBlks = reshape(real(r),n,length(r)/n).';%����Ϊn�ķ���
  %�������ֵ�����ҳ����ֵ��������
  [maxCorrVal,maxCorrIndex]=max((2*C-1)*rBlks.');
  cSoftBlks = C(maxCorrIndex,:);%��Ϊ�����������
  mSoftBlks = cSoftBlks(:,1:k);%ȥ�������е�У�����
  %�γɱ�����
  xSoftBlks = mSoftBlks.'; 
  xSoft=xSoftBlks(:).';
  BER_Hamming_Soft(i) = sum(sum(x~=xSoft))/numel(xSoft);%��������BER
end
BER_uncoded_theory=0.5*erfc(sqrt(10.^(EbN0dB/10)));%BPSK������BER(�ޱ���)
figure;
semilogy(EbN0dB,BER_Hamming_Hard,'r*-'); hold on;
semilogy(EbN0dB,BER_Hamming_Soft,'bo-'); 
semilogy(EbN0dB,BER_uncoded_theory,'k-'); grid on;
legend('(7,4) ������ (Ӳ��)','(7,4) ������ (����)',...
    '�ޱ��� BPSK (����)');
xlabel('Eb/N0(dB)');ylabel('������BER');
title('AWGN�ŵ���BPSK���Ƶ�BER����');
ylim([1e-5,1])