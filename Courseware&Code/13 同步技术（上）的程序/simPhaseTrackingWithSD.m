% ������С��ƽ���SD��������λ
clearvars;close all;

Ts=1/10000;                 % �������
time=1;                     % ����ʱ��
t=0:Ts:time-Ts;             % ����ʱ��ʸ��
fc=100;                     % �ز�Ƶ��
phoff=-0.8;                 % ��λ
rp=cos(4*pi*fc*t+2*phoff);  % ƽ��������ź�
mu=.001;                    % �㷨����
theta=zeros(1,length(t));   % ��λ���ƽ��������ռ䣩
theta(1)=0;                 % ��ʼ��λ
fl=25;                      % ƽ��������
h=ones(1,fl)/fl;            % ƽ��ϵ��
z=zeros(1,fl);              % ����ƽ�������buffer
f0=fc;                 
for k=1:length(t)-1           
  filtin=2*(rp(k)-0.5*cos(4*pi*f0*t(k)+2*theta(k)))...
      *sin(4*pi*f0*t(k)+2*theta(k));
  z=[z(2:fl), filtin];                
  theta(k+1)=theta(k)-mu*fliplr(h)*z'; % ����
end
plot(t,theta)                          % ���Ƶ���λ�仯����
title('������С��ƽ���SD��������λ')
xlabel('ʱ��'); ylabel('��λ')