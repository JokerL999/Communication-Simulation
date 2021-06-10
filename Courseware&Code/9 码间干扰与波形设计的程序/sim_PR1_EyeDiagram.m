close all; clearvars;
rng default;

N = 1e5; % ���͵ķ�����Ŀ
M = 2;   %���ƽ���
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
Nsym=8 ;%�˲�����ȣ��Է���Ϊ��λ������ʱ��,-Nsym/2~Nsym/2��
Q=[1 1]; %PR Class I Duobinary scheme
[b,t]=PRSignaling(Q,L,Nsym);% ������Ӧ�ĳ弤��Ӧ
filtDelay=(length(b)-1)/2; %FIR filter delay
s=conv(v,b,'full');%Convolve modulated syms with p[n] filter
figure; plot(real(s),'r'); title('�����˲�����źŲ��� s(n)');
xlim([0,30*L])

figure;
plotEyeDiagram(s,L,6*L,2*filtDelay,100);



