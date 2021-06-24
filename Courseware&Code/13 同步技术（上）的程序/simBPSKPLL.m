%BPSK信号的载波恢复（PLL）
clear,close all,
rng default

Tsym=1;        %符号周期
Rsym=1/Tsym;   %符号速率

Fc=4*Rsym;     %载频
Fsam=5*Fc;     %采样频率
Tsam=1/Fsam;   %采样周期
L=Tsym/Tsam;   %每符号样点数 

Nsym=30;       %仿真符号数
ds=randi([0 1],1,Nsym)*2-1;           % 1和-1的BPSK数据序列
dt=reshape(repmat(ds,L,1),1,Nsym*L);
NT=length(ds)*L;                      % 所有采样点的长度
phi=pi +pi/20*sin(0.1*[1:NT]*2*pi); % 模拟输入信号中变化的相位 

%椭圆滤波器设计：过渡带窄，通带和阻带等波纹。
fp=Fc/(Fsam/2);
fs=fp*1.2;
Rp=3;    % 通带波纹[dB]
As=40;   % 阻带衰减[dB]
[Norder,fc0]= ellipord(fp,fs,Rp,As);     % 计算滤波器阶数[Norder]和截止频率[fc0]
[Bde,Ade]= ellip(Norder,Rp,As,fc0);      % 椭圆滤波器设计
zi_c=zeros(1,max(length(Bde),length(Ade))-1); %相干解调的滤波器状态
zi_i=zeros(1,max(length(Bde),length(Ade))-1); %非相干解调的滤波器状态

zeta=0.707;  %阻尼系数
wn=2*2*pi*Fc/16;    %自然频率，通常小于载频的1/15
% PLL滤波器参数
T2=max(2*zeta/wn,Tsam/pi);
T1=10*T2;
Kc=2*wn^2*T1; 
% 利用双线性变换法，把模拟的环路滤波器(T2*s+1)/(T1*s)离散化
% [bLF,aLF]=bilinear([T2 1],[T1 0],1/Tsam,1/T2/2/pi)
[bLF,aLF]=bilinear([T2 1],[T1 0],1/Tsam);
% 利用双线性变换法，把VCO (Kv/s)离散化
[bVCO,aVCO]=bilinear(Kc,[1 0],1/Tsam);

t=0:Tsam:(NT-1)*Tsam;          % 时间矢量
s=dt.*cos(2*pi*Fc.*t+phi);     % 接收信号
xin=s.^2;                      % 接收信号平方

ziLF=zeros(1,max(length(aLF),length(bLF))-1);    %保存LF滤波器状态
ziVCO=zeros(1,max(length(aVCO),length(bVCO))-1); %保存VCO滤波器状态

e=zeros(1,NT);                %LF输入信号
theta_2=zeros(1,NT);          %两倍相位估计
theta=zeros(1,NT);            %相位估计
slf=zeros(1,NT);              %LF的输出信号
r_dem_c=zeros(1,NT);          %相干解调的解调波形
r_dem_i=zeros(1,NT);          %非相干解调的解调波形
r_dt_c=zeros(1,NT);           %相干解调恢复的基带波形
r_dt_i=zeros(1,NT);           %非相干解调恢复的基带波形
for k=1:NT
    e(k)=xin(k).*sin(2*pi*2*Fc.*t(k)+theta_2(k));        
    [slf(k+1),ziLF]=filter(bLF,aLF,e(k),ziLF);
    [theta_2(k+1),ziVCO]= filter(bVCO,aVCO,slf(k+1),ziVCO);% 通过VCO滤波器，输出相位估计       
    
    theta(k)=(theta_2(k)-pi/2)/2;                     % 移相-90°，再二分频
    
    r_dem_c(k)=s(k)*2*cos(2*pi*Fc.*t(k)+theta(k));    % 相干解调：有相位补偿    
    [r_dt_c(k),zi_c]=filter(Bde,Ade,r_dem_c(k),zi_c); % 滤除高频分量，得到基带信号    
    r_dem_i(k)=s(k)*2*cos(2*pi*Fc.*t(k));             % 非相干解调：无相位补偿   
    [r_dt_i(k),zi_i]=filter(Bde,Ade,r_dem_i(k),zi_i); % 滤除高频分量，得到基带信号
end

figure
subplot(311);
plot(t,phi,'k',t,theta,'r')                             
title('相位跟踪')
xlabel('时间'); ylabel('相位')
legend('真实相位','估计相位')
subplot(312);
plot(t,dt,'k', t,r_dt_i,'r')
title('非相干解调：解调无相位补偿');
xlabel('时间')
ylabel('幅度')
subplot(313);
plot(t,dt,'k', t,r_dt_c,'r')
xlabel('时间')
ylabel('幅度')
title('相干解调：解调有相位补偿')
