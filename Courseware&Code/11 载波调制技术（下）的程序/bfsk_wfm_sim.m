%BFSK���η���
clear all;clc;close all
rng default

%% ��������
N=100000;         %���ͱ�����Ŀ,
EbN0dB = -4:2:10; %�����Eb/N0��dB��Χ
Fc = 400;         %��Ƶ
fsk_type = 'COHERENT'; %COHERENT/NONCOHERENT FSK generation at Tx
h = 1;            %����ָ���������FSK��h��СΪ0.5��0.5�ı���
                  %         �Է����FSK��h��СΪ1��Ϊ1�ı���
L = 40;           %����������
Fs = 8*Fc;        %����Ƶ��
Tb = L/Fs;        %��������
Fd = h/Tb;        %Ƶ��ƫ��

EbN0lin = 10.^(EbN0dB/10);
BER_coherent = zeros(length(EbN0dB),1); 
BER_nonCoherent = BER_coherent;

%% ����
a = randi([0,1],1,N);       %������������
[s,t,phase]=bfsk_mod(a,Fc,Fd,L,Fs,fsk_type); %BFSK����

for i=1:length(EbN0dB)
  Eb=L*sum(abs(s).^2)/(length(s)); %����ÿ�����ź�����
  N0= Eb/EbN0lin(i); %�����������ܶ�
  n = sqrt(N0/2)*(randn(1,length(s)));%��������
  r = s + n;

  if strcmpi(fsk_type,'COHERENT')
    a_cap1 =  bfsk_coherent_demod(r,Fc,Fd,L,Fs,phase);%��ɼ��
    a_cap2 =  bfsk_noncoherent_demod(r,Fc,Fd,L,Fs);%����ɼ��
    BER_coherent(i) = sum(a~=a_cap1)/N;%���BERͳ��
    BER_nonCoherent(i) = sum(a~=a_cap2)/N;%�����BERͳ��
  end
  if strcmpi(fsk_type,'NONCOHERENT')
     a_cap2 =  bfsk_noncoherent_demod(r,Fc,Fd,L,Fs);%����ɼ��
    BER_nonCoherent(i) = sum(a~=a_cap2)/N;%�����BERͳ��
  end 
end
coherent = 0.5*erfc(sqrt(EbN0lin/2));%��ɼ������BER
nonCoherent = 0.5*exp(-EbN0lin/2);   %����ɼ������BER

%% ���չʾ
figure; 
if strcmpi(fsk_type,'COHERENT')
  semilogy(EbN0dB,BER_coherent,'k*'); hold on; 
  semilogy(EbN0dB,BER_nonCoherent,'m*');
  semilogy(EbN0dB,coherent,'r-');
  semilogy(EbN0dB,nonCoherent,'b-');
  title('���BFSK���Ƶ�����');
  legend('������ɽ��','�������ɽ��','������ɽ��','���۷���ɽ��');
end
if strcmpi(fsk_type,'NONCOHERENT'),
  semilogy(EbN0dB,BER_nonCoherent,'m*'); hold on;
  semilogy(EbN0dB,nonCoherent,'b-');
  title('�����BFSK���Ƶ�����');
  legend('�������ɽ��','���۷���ɽ��');
end
xlabel('E_b/N_0 (dB)');ylabel('BER - P_b');