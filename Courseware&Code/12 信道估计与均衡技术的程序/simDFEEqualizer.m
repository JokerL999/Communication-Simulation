%�о�����������ʵ��
clearvars; clc;close all
%rng default

%% ��������
h = [0.2; 1; 0.1; 0.02]; % �ŵ��弤��Ӧ
mu = 0.001;              % ����
Nsym = 1e5;              % ѵ��������
M=2;

s = ceil(M.*rand(Nsym,1));%�����������
x = mpam_modulator(M,s)';  %MPAM����
r = filter(h,1,x);       % ͨ���ŵ�
K = length(h)+2;         % �����˲�������
f = zeros(K,1);          % �����˲���ϵ��ʸ��
P = length(h)-1;         % �����˲�������
d = zeros(P,1);          % �����˲���ϵ��ʸ��
x_bar_vec = zeros(P,1);
delta = 4;               % ���ʱ��

%% ����
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

dec=mpam_detector(M,x_hat');     % ����о�
% ����������
eqDelay = K-delta;
fprintf('BER %f\n',mean(s(eqDelay:eqDelay+Nsym-K) ~= dec'));


