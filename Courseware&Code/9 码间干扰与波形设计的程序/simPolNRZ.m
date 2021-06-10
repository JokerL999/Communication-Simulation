% 双极性非归零码编码的波形和功率谱分析

clear all;
close all;
rng('default');

Nb=10000;             %待传输的比特数目
Rb=2;                 %数据传输速率bit/s
L=10;                 %采样率提高倍数
fs=L*Rb;              %采样频率
inBits=randi([0,1],1,Nb);  %生成数据

[x,t]=PolNRZ_Coder(inBits,Rb,fs); %单极性非归零码编码

Nshow=10;             %展示的bit数目
plot(t(1:Nshow*L),x(1:Nshow*L));
xlabel('时间[s]')
ylabel('幅度')
ylim([-1.1,1.1])
str=strcat('双极性非归零码：',num2str(inBits(1:Nshow)));
title(str);

figure
N=length(x);
% [Pxx,f]=periodogram(x,rectwin(N),N,fs); 
% plot(f,pow2db(Pxx));
[pxx,f] = pwelch(x,[],[],[],fs);
plot(f,pow2db(pxx));

Tb=1/Rb;
f=0:0.05*Rb:5*Rb;
Pt=Tb*(sinc(f*Tb).*sinc(f*Tb));
hold on

plot(f,pow2db(Pt),'r')
ylim([-80,40])
grid on
xlabel('频率[Hz]')
ylabel('功率谱密度[dBW/Hz]')
legend('数值计算','理论分析')
title('双极性非归零码编码的功率谱')


function [output,t]=PolNRZ_Coder(in,Rb,fs)
%双极性非归零码编码器
%in 待编码的数据
%Rb 比特速率，bit/秒
%fs 采样率,次/秒

%output 输出样点
% t     样点对应的时刻

t=0:1/fs:length(in)-1/fs;

L=floor(fs/Rb);
x=sign(in-0.5);
x=repmat(x,L,1);
output=reshape(x,1,[]);
end
