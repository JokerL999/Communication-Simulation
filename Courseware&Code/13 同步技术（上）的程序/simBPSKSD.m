%BPSK信号的载波恢复（平方差分环）
clear,close all,
rng default

Tsym=1;        %符号周期
Rsym=1/Tsym;   %符号速率

Fc=4*Rsym;     %载频
Fsam=5*Fc;     %采样频率
Tsam=1/Fsam;   %采样周期
L=Tsym/Tsam;   %每符号样点数 

Nsym=30;       %仿真符号数
ds=randi([0 1],1,Nsym)*2-1;         % 1和-1的BPSK数据序列
dt=reshape(repmat(ds,L,1),1,Nsym*L);
NT=length(ds)*L;                   % 所有采样点的长度
phi=pi/3 +pi/20*sin([1:NT]*pi/200); % 模拟输入信号中变化的相位 

%椭圆滤波器设计：过渡带窄，通带和阻带等波纹。
fp=Fc/(Fsam/2);
fs=fp*1.2;
Rp=3;    % 通带波纹[dB]
As=40;   % 阻带衰减[dB]
[Norder,fc0]= ellipord(fp,fs,Rp,As);     % 计算滤波器阶数[Norder]和截止频率[fc0]
[Bde,Ade]= ellip(Norder,Rp,As,fc0);      % 椭圆滤波器设计
zi_c=zeros(1,max(length(Bde),length(Ade))-1); %相干解调的滤波器状态
zi_i=zeros(1,max(length(Bde),length(Ade))-1); %非相干解调的滤波器状态

theta=zeros(1,length(NT)); 
M=25;                          % 取最近的M个样点取平均
h=ones(1,M)/M;                 % 求平均系数
z=zeros(1,M); 
mu=0.1;

t=0:Tsam:(NT-1)*Tsam;         % 时间矢量
s=dt.*cos(2*pi*Fc.*t+phi);     % 接收信号
xin=s.^2;                      % 接收信号平方

r_dem_c=zeros(1,NT);          %相干解调的解调波形
r_dem_i=zeros(1,NT);          %非相干解调的解调波形
r_dt_c=zeros(1,NT);           %相干解调恢复的基带波形
r_dt_i=zeros(1,NT);           %非相干解调恢复的基带波形
for k=1:NT
    e=2*(xin(k)-1/2*cos(4*pi*Fc*t(k)+2*theta(k)))*sin(4*pi*Fc*t(k)+2*theta(k));
    z=[z(2:M), e];                 % z contains past inputs
    theta(k+1)=theta(k)-mu*fliplr(h)*z'; % update = z convolve h
    
    r_dem_c(k)=s(k)*2*cos(2*pi*Fc.*t(k)+theta(k));    % 相干解调：相位补偿    
    [r_dt_c(k),zi_c]=filter(Bde,Ade,r_dem_c(k),zi_c); % 滤除高频分量，得到基带信号
    
    r_dem_i(k)=s(k)*2*cos(2*pi*Fc.*t(k));             % 非相干解调：无相位补偿   
    [r_dt_i(k),zi_i]=filter(Bde,Ade,r_dem_i(k),zi_i); % 滤除高频分量，得到基带信号
end

figure
subplot(311);
plot(t,phi,'k',t,theta(1:end-1),'r')                             
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
