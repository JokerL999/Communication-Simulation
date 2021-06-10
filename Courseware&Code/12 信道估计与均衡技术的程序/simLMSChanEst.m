% 基于均方差LMS的信道估计
close all;clearvars;
rng default

h = [1; 0.7; 0.2];  % 待估计的信道
mu = 0.1;           % 步长
TrainSeqLen = 30;  % 训练序列的长度
x = sign(randn(TrainSeqLen,1)); % 训练序列
r = filter(h,1,x)+0.1*randn;    % 发送序列通过信道，并叠加噪声
L = length(h);      % 信道长度 
h_hat = zeros(L,1);
%% Estimate channel
for n = L:TrainSeqLen
    % 选择训练的部分序列作为输入
    in = x(n:-1:n-L+1);
    y = h_hat'*in;
    e = r(n)-y;
    h_hat = h_hat + mu*conj(e)*in;
end

[h h_hat]

Fs = 1e6; N = 64;
htrue=freqz(h,1,N,Fs,'whole');
[hb,we]=freqz(h_hat,1,N,Fs,'whole');
semilogy(we,abs(hb),'b')
hold on;semilogy(we,abs(htrue),'bo');hold off
grid on;xlabel('频率 (Hz)');ylabel('幅度');
legend('信道估计','实际信道','Location','Best');
