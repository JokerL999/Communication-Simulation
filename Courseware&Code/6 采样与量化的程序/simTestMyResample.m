%ʵ����һ���Զ���Ĳ����ʵ�������������Matlab��resample�����˱Ƚ�
clearvars;
close all;

L = 3; M = 2; % set the up- and downsampling factors
N = 30; % length of the signal
f1 = 0.043; % frequency of 1st sinusoid
f2 = 0.031; % frequency of 2nd sinusoid
n = 0:N-1;
xn = sin(2*pi*f1*n) + sin(2*pi*f2*n);

%ʹ��Matlab�ٷ�����
ym = resample(xn, L,M);

m = 0:length(ym)-1; % create a new index
figure
subplot(3, 1, 1)
stem(n, xn)
xlabel('Time index n'); ylabel('Amplitude')
title('Input sequence')
subplot(3, 1, 2)
stem(m, ym)
xlabel('Time index n'); ylabel('Amplitude')
title('Output sequence from Matlab Official Function')

%ʹ���Լ��ĺ���
ymy = MyResample(xn, L, M);
subplot(3, 1, 3)
stem(0:length(ymy)-1, ymy)
xlabel('Time index n'); ylabel('Amplitude')
title('Output sequence from My Function')


