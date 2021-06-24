% ����Costas��ʵ����λ����

clearvars; close all;
rng default;

Nsym=1000;                 %������
L=20;                      %����������
M=4;                       %MPAM�ĵ��ƽ���
Ts=.0001;                  %��������
Fs=1/Ts;                   %����Ƶ��

%% �����źŲ���
time=Ts*Nsym*L;            %����ʱ�䳤��
t=Ts:Ts:time;              %����ʱ��ʸ��
d = ceil(M.*rand(1,Nsym)); %�����������
m = mpam_modulator(M,d);   %MPAM����
mup=zeros(1,Nsym*L); 
mup(1:L:Nsym*L)=m;         % ������,ÿ������֮��ΪL-1��0
ps=hamming(L);             % ���ΪL�����岨�Σ���hamming��Ϊ����
s=filter(ps,1,mup);        % ���������岨�ξ��

%% �����ز����ز�����
fc=1000;                   % �ز�Ƶ��
phoff=1.0;                 % ��λ
c=cos(2*pi*fc*t+phoff);    % �����ز��ź�
r=s.*c;                    % �ز����ƣ������ز���

n=500;                     % LPF�Ľ���  
ff=[0 .01 .02 1];          % ��ͨ�˲����Ľ�ֹƵ��ԶС��2*fc/(Fs/2)=0.4
fa=[1 1 0 0];
h=firpm(n,ff,fa);          % LPF
mu=.003;                   % �㷨����
f0=1000;                   % ���ջ���Ƶ��
theta=zeros(1,length(t));  % ������λʸ��
theta(1)=0;                % ��ʼ����
zs=zeros(1,n+1); zc=zeros(1,n+1);   % �˲�������Ļ���
for k=1:length(t)-1                   
  zs=[zs(2:n+1), 2*r(k)*sin(2*pi*f0*t(k)+theta(k))];
  zc=[zc(2:n+1), 2*r(k)*cos(2*pi*f0*t(k)+theta(k))];
  lpfs=fliplr(h)*zs'; lpfc=fliplr(h)*zc'; % �˲������
  theta(k+1)=theta(k)-mu*lpfs*lpfc;   % ����Ӧ�㷨����
end

plot(t,theta),
title('����Costas������λ����')
xlabel('ʱ��'); ylabel('��λƫ��')
