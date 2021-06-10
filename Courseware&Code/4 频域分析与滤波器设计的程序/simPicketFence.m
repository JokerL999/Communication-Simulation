%ʾ��դ������
clearvars; close all;

%% ������Ƶ�ʷֱ��ʵ�Ƶ�ʷ���
Fs = 20; Ts = 1/Fs; f1=5; f2=4.5;
t = 0:Ts:2;   
xt = 1+sin(2*pi*f1*t) + sin(2*pi*f2*t);
[Xf, f] = SimpleSpectrumViewer(xt, Fs);

subplot(221)
plot(t, xt)
xlabel('t'); ylabel('ʱ�����'); title('ʱ���ź�')
subplot(223)
plot(f, abs(Xf));xlabel('f');ylabel('������')
title('������Ƶ��ֱ��ʼ����Ƶ��')

%% �趨Ƶ�ʷֱ��ʵ�Ƶ�ʷ���
Fdelta=0.1;                                    %Ƶ�ʷֱ���
M=Fs/Fdelta;                                   %ʵ��Ƶ�ʷֱ��ʵ����г���
t=0:Ts:(M-1)*Ts;
xt =1+sin(2*pi*f1*t) + sin(2*pi*f2*t);          %�źŲ���
[Xf, f] = SpectrumViewer(xt,Fs,'onesided',Fdelta);         %�趨Ƶ�ʷֱ��ʵ�Ƶ�����

subplot(222)
plot(t, xt);xlabel('t');ylabel('ʱ�����');title('ʱ���ź�')
subplot(224)
plot(f, abs(Xf));xlabel('f');ylabel('������');title('����Ƶ�ʷֱ��ʼ����Ƶ��')