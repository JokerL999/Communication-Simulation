%判决反馈均衡器实例
clearvars; clc;close all
%rng default

%% 参数设置
h = [0.2; 1; 0.1; 0.02]; % 信道冲激响应
mu = 0.001;              % 步长
Nsym = 1e5;              % 训练符号数
M=2;

s = ceil(M.*rand(Nsym,1));%生成随机符号
x = mpam_modulator(M,s)';  %MPAM调制
r = filter(h,1,x);       % 通过信道
K = length(h)+2;         % 横向滤波器阶数
f = zeros(K,1);          % 横向滤波器系数矢量
P = length(h)-1;         % 反馈滤波器阶数
d = zeros(P,1);          % 反馈滤波器系数矢量
x_bar_vec = zeros(P,1);
delta = 4;               % 输出时延

%% 仿真
index = 1;
[e,x_hat]=deal(zeros(Nsym-K+1,1)); 
for n = K:Nsym
    in = r(n:-1:n-K+1);
    x_hat(index) = f'*in - d'*x_bar_vec;
    e = x(n-delta)-x_hat(index);
    f = f + mu*conj(e)*in;
    d = d - mu*conj(e)*x_bar_vec;
    x_bar_vec = [x(n-delta);x_bar_vec(1:end-1)];
    index = index + 1;
end

dec=mpam_detector(M,x_hat');     % 解调判决
% 计算误码率
eqDelay = K-delta;
fprintf('BER %f\n',mean(s(eqDelay:eqDelay+Nsym-K) ~= dec'));


