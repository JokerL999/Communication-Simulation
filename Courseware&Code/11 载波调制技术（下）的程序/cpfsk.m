clear all;clc;close all
rng default

L=50;                 %����������
Tb=0.5;               %��������[��]
fs=L/Tb;              %����Ƶ��[Hz]
fc=2/Tb;              %��Ƶ
N = 8;                %���͵ı�����
h=0.5;                %����ָ��
b=2*(rand(N,1)>0.5)-1;%�����Ϣ���� +1/-1 
b=repmat(b,1,L).';    %������
b=b(:).';             %���л�
theta= pi*h/Tb*filter(1,[1 -1],b,0)/fs;%FIR�����˲���
t=0:1/fs:Tb*N-1/fs;  %ʱ��ʸ��
s = cos(2*pi*fc*t + theta); %CPFSK signal

subplot(3,1,1);plot(t,b);xlabel('t');ylabel('b(t)');
subplot(3,1,2);plot(t,theta);xlabel('t');ylabel('\theta(t)');
subplot(3,1,3);plot(t,s);xlabel('t');ylabel('s(t)');