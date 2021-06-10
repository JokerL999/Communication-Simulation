% ������С���˵��ŵ�����
close all;clearvars;
rng default

h = [1; 0.7; 0.2]; % �����Ƶ��ŵ�
TrainSeqLen = 30;  % ѵ�����еĳ���
x = sign(randn(TrainSeqLen,1)); % ѵ������
r = filter(h,1,x)+0.1*randn;    % ��������ͨ���ŵ�������������
L = length(h);     % �ŵ����� 
s=zeros(TrainSeqLen,L);
for i=1:L
    s(i:end,i)=x(1:end-i+1); %����ѵ�����еľ���
end
h_hat=inv(s.'*s)*s.'*r; % ����LS�ŵ�����

[h h_hat]

Fs = 1e6; N = 64;
htrue=freqz(h,1,N,Fs,'whole');
[hb,we]=freqz(h_hat,1,N,Fs,'whole');
semilogy(we,abs(hb),'b')
hold on;semilogy(we,abs(htrue),'bo');hold off
grid on;xlabel('Ƶ�� (Hz)');ylabel('����');
legend('�ŵ�����','ʵ���ŵ�','Location','Best');


