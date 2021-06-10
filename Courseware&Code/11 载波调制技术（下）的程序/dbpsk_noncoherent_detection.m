%% ���BPSK�ķ���ɼ��
clear all;clc;close all
rng default

%% ��������
N=1e5   ;         %���͵ķ�����Ŀ
EbN0dB = -4:2:10; % �����Eb/N0��dB��Χ
L=8;              %����������
Fc=800;           %��Ƶ
Fs=L*Fc;          %����Ƶ��

EbN0lin = 10.^(EbN0dB/10); 
BER_suboptimum = zeros(length(EbN0dB),1);

%% �����źŵ����뷢�䲨��
a = randi([0,1],N,1);       %������������
b = filter(1,[1 -1],a,0);  %IIR��ֱ���
b = mod(b,2);              %ģ2����
[s_bb,t]= bpsk_mod(b,L);    %����BPSK����
s = s_bb.*cos(2*pi*Fc*t/Fs); %�ز�����

%% ���ղ��μ��
for i=1:length(EbN0dB)
    Esym=L*sum(abs(s).^2)/length(s); %�ź�����
    N0= Esym/EbN0lin(i); %���㹦�����ܶ�
    n=sqrt(N0/2)*(randn(1,length(s))+1i*randn(1,length(s)));%noise
    
    r = s + n;%ͨ��AWGN�ŵ�  
    p=real(r).*cos(2*pi*Fc*t/Fs);%���ô�ͨ�˲������������    
    w0=[p zeros(1,L)];%������β����L��0
    w1=[zeros(1,L) p];%������ͷ��L��0
    w = w0.*w1;%ʱ�Ӻ����
    z = conv(w,ones(1,L));%����
    u = z(L:L:end-L);     % t=kTbʱ���ϲ���
    a_cap = u.'<0;        % �о�
    BER_suboptimum(i) = sum(a~=a_cap)/N;%BERͳ��   
end
%����BER��SER
theory_DBPSK_suboptimum = 0.5.*exp(-0.76*EbN0lin);
theory_DBPSK_coherent=erfc(sqrt(EbN0lin)).*(1-0.5*erfc(sqrt(EbN0lin)));
theory_BPSK_conventional = 0.5*erfc(sqrt(EbN0lin));

%% ���չʾ
figure;semilogy(EbN0dB,BER_suboptimum,'k*','LineWidth',1.0);
hold on;
semilogy(EbN0dB,theory_DBPSK_suboptimum,'m-','LineWidth',1.0);
semilogy(EbN0dB,theory_DBPSK_coherent,'k-','LineWidth',1.0);
semilogy(EbN0dB,theory_BPSK_conventional,'b-','LineWidth',1.0);
set(gca,'XLim',[-4 12]);set(gca,'YLim',[1E-6 1E0]);
set(gca,'XTick',-4:2:12);title('���BPSK����ɼ������');
xlabel('E_b/N_0 (dB)');ylabel('BER - P_b');
legend('DBPSK ���� (����)','DBPSK ���� (����)','��� DEBPSK','��� BPSK');