%信道幅频和相频的影响示意，
close all; clearvars; clc;
rng default
 
%% 参数设置
Tsym=1;                    %每个符号周期
L = 8;                     %每个码元的抽样点数
Tsam = Tsym/L;             %抽样时间间隔
Fs=1/Tsam;                 %采样频率
Nsym= 50;                  %数据的码元长度

%% 数据波形
gt = ones(1,L);                     %NRZ非归零波形 
t = 0:Tsam:(Nsym*L-1)*Tsam;         %样点对应的时间矢量
d = 2*randi([0,1],1,Nsym)-1;        %双极性数据源
data = INSERT0(d,L);                %对序列间隔插入N_sample-1个0 
xt=filter(gt,1,data);               %信源波形
[Xf, f] = SpectrumViewer(xt,Fs, 'twosided');   % 计算发送波形的频谱
subplot(211)
plot(t, xt);xlabel('t');ylabel('时域幅度');title('时域信号')
axis([0,20,-1.2 1.2]);grid on;
subplot(212)
plot(f, abs(Xf));xlabel('f[Hz]');ylabel('幅度谱');title('发送信号的频谱')

N = 128;                             %信道传递函数的频域采样数
f=floor(-N/2+0.5:N/2-0.5)*Fs/N;      %信道传递函数的频域采样的频点矢量 
%% 信道1：无失真信道
hf1 = exp(-1j*2*pi*f);          % 无失真信道的频率响应，时域延迟1秒
[ht1,~] = SignalRecoveryFromSpectrum(hf1,f);          % 由频谱得到时域响应
yt1 = filter(ht1,1,xt);         % 滤波

figure
subplot 311
yyaxis left
plot(f,abs(hf1));ylabel('幅频特性');ylim([0.5,1.5])
yyaxis right
plot(f,angle(hf1)/pi);
ylabel('相频特性');title('线性无失真信道的幅频和相频特性');
grid on;
subplot 312
plot(t,xt(1:Nsym*L));
axis([0,20,-1.2 1.2]);grid on;
title('输入信号波形')
subplot 313
plot(t,real(yt1(1:Nsym*L)));
title('经过信道后的输出信号');
axis([0,20,-1.2 1.2]);grid on;
title('输出信号波形')

%% 信道2：幅频失真信道
hf2 = sinc(f).*exp(-1i*pi*f);
[ht2,~] = SignalRecoveryFromSpectrum(hf2,f);        % 由频谱得到时域响应
yt2 = filter(ht2,1,xt);       % 滤波

figure
subplot 311
yyaxis left
plot(f,abs(hf2))
ylabel('幅频特性');
ylim([0,1])
yyaxis right
plot(f,angle(hf2)/pi);
ylabel('相频特性');title('幅频失真信道的幅频和相频特性');
grid on;
subplot 312
plot(t,xt(1:Nsym*L));
axis([0,20,-1.2 1.2]);grid on;
title('输入信号波形')
subplot 313
plot(t,real(yt2(1:Nsym*L)));
title('经过信道后的输出信号');
axis([0,20,-1.2 1.2]);grid on;
title('输出信号波形')

%% 信道3：相位失真信道
f1 = find(f<0); 
hf3 = exp(-1i*pi*f+1i*pi );
hf3(f1) = exp( -1i*pi*f(f1)-1i*pi );
[ht3,~] = SignalRecoveryFromSpectrum(hf3,f);          % 由频谱得到时域响应
yt3 = filter(ht3,1,xt);       % 滤波

figure
subplot 311
yyaxis left 
plot(f,abs(hf3))
ylabel('幅频特性');
ylim([0,2])
yyaxis right
plot(f,angle(hf3)/pi);
ylabel('相频特性');title('相位失真信道信道的幅频和相频特性');
grid on;
subplot 312
plot(t,xt(1:Nsym*L));
axis([0,20,-1.2 1.2]);grid on;
title('输入信号波形')
subplot 313
plot(t,real(yt3(1:Nsym*L)));
title('经过信道后的输出信号');
axis([0,20,-1.2 1.2]);grid on;
title('输出信号波形')

%% 信道4：相频、群时延失真信道
hf4 = exp(-1i*pi*f.*f-1i*pi*f+1i*pi);
[ht4,~] = SignalRecoveryFromSpectrum(hf4,f);          % 由频谱得到时域响应
yt4 = filter(ht4,1,xt);       % 滤波

figure
subplot 311
yyaxis left 
plot(f,abs(hf4))
ylabel('幅频特性');
ylim([0,2])
yyaxis right
plot(f,angle(hf4)/pi);
ylabel('相频特性');title('相位失真信道信道的幅频和相频特性');
grid on;
subplot 312
plot(t,xt(1:Nsym*L));
axis([0,20,-1.2 1.2]);grid on;
title('输入信号波形')
subplot 313
plot(t,real(yt4(1:Nsym*L)));
title('经过信道后的输出信号');
axis([0,20,-1.2 1.2]);grid on;
title('输出信号波形')