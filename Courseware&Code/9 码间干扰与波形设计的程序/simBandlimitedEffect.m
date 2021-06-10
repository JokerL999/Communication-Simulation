clearvars;close all; 
rng default

Tsym=1;
L=16;     %过采样因子（每个符号的样点数目）
Nsym=100; %生成符号数
Nshow=16; %画图展示的符号数
dt=Tsym/L;
FilterSpanSym=6; %滤波器跨度（以符号为单位，持续时间,-Nsym/2~Nsym/2）

inBits=2*randi([0,1],1,Nsym)-1; %生成双极性数字信号
t=0:1/L:length(inBits)-1/L;
din=repmat(inBits,L,1);
din=reshape(din,1,[]);

dd=sigexpand(inBits,L); %补零升采样
%基带系统冲击响应（sinc函数，低通滤波器）
[ht,~]=sincFunction(L,Tsym,FilterSpanSym);
st=conv(dd,ht);
tt=-FilterSpanSym/2*Tsym:dt:(Nsym+FilterSpanSym/2)*L*dt-dt; %通过滤波器，增加FilterSpanSym/2

subplot(211)
plot(t,din)
xlim([0,Nshow*Tsym])
str=strcat('发送信号波形：',num2str(inBits(1:Nshow)));
title(str);
subplot(212)
plot(tt,st);
xlim([0,Nshow*Tsym])
xlabel('时间 t/Tsym');
title('接收信号波形');

function [out]=sigexpand(d,M)% M倍升采样
N=length(d);
out=zeros(M,N);
out(1,:)=d;
out=reshape(out,1,M*N);
end

