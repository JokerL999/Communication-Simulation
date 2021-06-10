clearvars; clc;close all
rng default

%% 参数设置
L=5;     %过采样因子,每符号的样点数目
Fs=100;  %采样率
Ts=1/Fs; %采样周期
Tsym=L*Ts; %符号周期

%信道传递函数
k=6;                            %信道响应的符号跨度（-k*Tsym~k*Tsym）
N0 = 0.1;                       %AWGN信道噪声标准方差
t = -k*Tsym:Ts:k*Tsym;          %时间矢量
h = 1./(1+(t/Tsym).^2);         %带限信道模型
h = h + N0*randn(1,length(h));  %加入噪声
h_c= h(1:L:end);                %下采样，达到符号采样率
t_inst=t(1:L:end);              %下采样后的时间矢量

figure;
plot(t,h);            %按过采样因子采样的信道响应
hold on;
stem(t_inst,h_c,'r'); %按符号采样率采样的信道响应
hold off
legend('信道响应','符号采样率下的信道响应');
title('带限信道的时域冲激响应');
xlabel('时间(s)');ylabel('幅度');

%% MMSE均衡器及其频域响应
%均衡器设计参数
nTaps = 14;          %FIR滤波器抽头数目
snr = 10*log10(1/N0^2); % 信号功率（假设为1）/噪声功率，转化为SNR[dB] 
[h_eq,MSE,optDelay]=mmse_equalizer(h_c,snr,nTaps);
xn=h_c; 
h_sys=conv(h_eq,h_c); %信道和均衡滤波器的总体效应

disp(['MMSE均衡器设计: N=', num2str(nTaps), ' Delay=',num2str(optDelay)])
disp('MMSE均衡器权重:'); disp(h_eq)

%% MMSE均衡器时域影响
figure; 
subplot(1,2,1); stem(0:1:length(xn)-1,xn); title('均衡器输入'); 
xlabel('样点'); ylabel('幅度');

subplot(1,2,2); stem(0:1:length(h_sys)-1,h_sys);
title(['均衡器输出：N=', num2str(nTaps),' 时延=',num2str(optDelay)]); 
xlabel('样点'); ylabel('幅度');