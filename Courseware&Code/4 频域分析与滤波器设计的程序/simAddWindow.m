%й¶�����뺺���Ӵ�
clearvars;close all;

Ts = 0.01;
Fs = 1/Ts;
%% ԭʼ�ź�
t = 0:Ts:1;
xt = sin(2*pi*5*t) + sin(2*pi*10*t);   %�źŲ���
[Xf, f] = SpectrumViewer(xt, Fs);      %Ƶ�׷���

subplot(221)
plot(t, xt);xlabel('t');ylabel('����');title('ԭʱ���ź�')
subplot(223)
plot(f, abs(Xf));xlabel('f');ylabel('������')
xlim([0 100]);ylim([0 1])
title('ԭʱ���ź�Ƶ��')

%% �Ӻ�����
win = hann(length(t));
xt1= xt.*win';                      % �Ӻ�����
[X1, f1] = SpectrumViewer(xt1, Fs); % Ƶ�׷���
Xf1=2*X1;                           % �Ӵ���ķ�������

subplot(222)
plot(t, xt1);xlabel('t');ylabel('ʱ�����')
title('�Ӵ��ź�')
subplot(224)
plot(f1, abs(Xf1))
xlabel('f');ylabel('������');title('�Ӵ��ź�Ƶ��')
xlim([0 100]);ylim([0 1])