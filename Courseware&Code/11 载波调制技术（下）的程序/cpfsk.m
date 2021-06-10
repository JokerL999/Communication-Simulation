clear all;clc;close all
rng default

L=50;                 %过采样因子
Tb=0.5;               %比特周期[秒]
fs=L/Tb;              %采样频率[Hz]
fc=2/Tb;              %载频
N = 8;                %发送的比特数
h=0.5;                %调制指数
b=2*(rand(N,1)>0.5)-1;%随机信息序列 +1/-1 
b=repmat(b,1,L).';    %过采样
b=b(:).';             %序列化
theta= pi*h/Tb*filter(1,[1 -1],b,0)/fs;%FIR积分滤波器
t=0:1/fs:Tb*N-1/fs;  %时间矢量
s = cos(2*pi*fc*t + theta); %CPFSK signal

subplot(3,1,1);plot(t,b);xlabel('t');ylabel('b(t)');
subplot(3,1,2);plot(t,theta);xlabel('t');ylabel('\theta(t)');
subplot(3,1,3);plot(t,s);xlabel('t');ylabel('s(t)');