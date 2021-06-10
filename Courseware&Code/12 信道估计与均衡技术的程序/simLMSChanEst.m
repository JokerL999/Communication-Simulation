% ���ھ�����LMS���ŵ�����
close all;clearvars;
rng default

h = [1; 0.7; 0.2];  % �����Ƶ��ŵ�
mu = 0.1;           % ����
TrainSeqLen = 30;  % ѵ�����еĳ���
x = sign(randn(TrainSeqLen,1)); % ѵ������
r = filter(h,1,x)+0.1*randn;    % ��������ͨ���ŵ�������������
L = length(h);      % �ŵ����� 
h_hat = zeros(L,1);
%% Estimate channel
for n = L:TrainSeqLen
    % ѡ��ѵ���Ĳ���������Ϊ����
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
grid on;xlabel('Ƶ�� (Hz)');ylabel('����');
legend('�ŵ�����','ʵ���ŵ�','Location','Best');
