clearvars; clc;close all

L = 50; %���������� Tsym/Ts
Nsym = 8; %������Ӧϵͳ�˲������
QD_arr = cell(8,1); %place holder for 8 different PR co-effs Q(D)
QD_arr{1}=[1 1]; %PR Class I Duobinary scheme
QD_arr{2}=[1 -1]; %PR Class I Dicode channel scheme
QD_arr{3}=[1 2 1]; %PR Class II
QD_arr{4}=[2 1 -1]; %PR Class III
QD_arr{5}=[1 0 -1]; %PR Class IV (Modified Duobinary)
QD_arr{6}=[1 1 -1 -1]; %EPR4 (Enhanced Class IV)
QD_arr{7}=[1 2 0 -2 -1]; %E2PR4 (Enhanced EPR4)
QD_arr{8}=[1 0 -2 0 1]; %PR Class V
A=1;%filter co-effs in Z-domain(denominator) for any FIR type filter
titles={'PR1 Duobinary','PR1 Dicode','PR Class II','PR Class III'...
    ,'PR4 Modified Duobinary','EPR4','E2PR4','PR Class V'};

i=1;
Q = QD_arr{i}; %Q�˲�����ͷֵ    
[b,t]=PRSignaling(Q,L,Nsym);% ������Ӧ�ĳ弤��Ӧ
subplot(1,2,1);
plot(t,b); 
hold on;
stem(t(1:L:end),b(1:L:end),'r'); 
grid on; title([titles{i} '- b(t)']);
xlabel('t/T_{sym}'); 
ylabel('b(t)'); 
hold off;

[H,W]=freqz(Q,A,1024,'whole');%Ƶ����Ӧ
H=[H(length(H)/2+1:end); H(1:length(H)/2)];%�����õ�˫����
response=abs(H);
norm_response=response/max(response);%��һ������
norm_frequency= W/max(W)-0.5;%��һ��Ƶ�� -0.5 to 0.5
subplot(1,2,2);
plot(norm_frequency,norm_response,'b');
grid on; 
title([titles{i} '- Frequency response Q(D)'])
xlabel('f/F_{sym}');
ylabel('|Q(D)|')   

