close all; clearvars;
rng default;


N = 1e5; % ���͵ķ�����Ŀ
M = 4;   %���ƽ���
d = ceil(M.*rand(1,N)); %�����������

% PAM����
u = mpam_modulator(M,d);%MPAM����
figure; 
stem(real(u)); 
xlim([0,20])
ylim([-5,5])
title('PAM�����ź�u[k]');

% �ϲ���
L=4; % ����������
v=[u;zeros(L-1,length(u))];%ÿ������֮���L-1����
v=v(:).';
figure
stem(real(v)); 
title('�������ź�v(n)');
xlim([0,30*L])
ylim([-5,5])

% �����˲�
beta = 0.3;% ��������
Nsym=8 ;%�˲�����ȣ��Է���Ϊ��λ������ʱ��,-Nsym/2~Nsym/2��
[p,t] = srrcFunction(beta,L,Nsym);%ƽ�����������˲�������
filtDelay=(length(p)-1)/2; %FIR filter delay
s=conv(v,p,'full');%Convolve modulated syms with p[n] filter
figure; plot(real(s),'r'); title('�����˲�����źŲ��� s(n)');
xlim([0,30*L])


% ͨ���ŵ�
EbN0dB = 10; %�ŵ��ı��������dBֵ
snr = 10*log10(log2(M))+EbN0dB; %��Eb/N0ת��SNR
r = add_awgn_noise(s,snr,L); %ͨ��AWGN�ŵ�
figure; plot(real(r),'r');title('�����ź� r(n)');
xlim([0,30*L])

vCap=conv(r,p,'full');%����ƥ���˲�
figure; 
plot(real(vCap),'r');
title('ƥ���˲���');
xlim([0,30*L])
%ƥ���˲�����ͼ
figure;
plotEyeDiagram(vCap,L,3*L,2*filtDelay,100);

% �����ʲ������²���
uCap = vCap(2*filtDelay+1:L:end-(2*filtDelay))/L;
figure; stem(real(uCap)); hold on;
xlim([0,30])
title('�²�����');
dCap = mpam_detector(M,uCap); %���

