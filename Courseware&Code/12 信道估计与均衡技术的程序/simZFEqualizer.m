clearvars; clc;close all

%% 参数设置
L=5;     %过采样因子,每符号的样点数目
Fs=100;  %采样率
Ts=1/Fs; %采样周期
Tsym=L*Ts; %符号周期

%信道传递函数
k=6;                            %信道响应的符号跨度（-k*Tsym~k*Tsym）
N0 = 0.01;                      %AWGN信道噪声标准方差
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

%% ZF均衡器及其频域响应
%均衡器设计参数
nTaps = 14;          %FIR滤波器抽头数目
[h_eq,error,optDelay]=zf_equalizer(h_c,nTaps);
xn=h_c; 
h_sys=conv(h_eq,h_c); %信道和均衡滤波器的总体效应

%频域响应：信道、ZF均衡器和总体效应 
[H_c,W]=freqz(h_c);    
[H_eq,W]=freqz(h_eq);   
[H_sys,W]=freqz(h_sys); 

%频域响应绘图
figure; plot(W/pi,20*log10(abs(H_c)/max(abs(H_c))),'g'); hold on; 
plot(W/pi,20*log10(abs(H_eq)/max(abs(H_eq))),'r'); 
plot(W/pi,20*log10(abs(H_sys)/max(abs(H_sys))),'k');
legend('信道','ZF均衡器','总体效应');
title('频率响应'); ylabel('幅度 (dB)');
xlabel('归一化频率 (x \pi rad/sample)');


%% ZF均衡器时域影响
figure; 
subplot(1,2,1); stem(0:1:length(xn)-1,xn); title('均衡器输入'); 
xlabel('样点'); ylabel('幅度');

subplot(1,2,2); stem(0:1:length(h_sys)-1,h_sys);
title(['均衡器输出- N=', num2str(nTaps),...
    ' 时延=',num2str(optDelay), ' 误差=', num2str(error)]); 
xlabel('样点'); ylabel('幅度');