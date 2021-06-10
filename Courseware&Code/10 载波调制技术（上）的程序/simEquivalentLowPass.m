clear all; clc; close all;
 
fs=400;                                 % ����Ƶ��
N=400;                                  % ���ݳ���
n=0:1:N-1;
dt=1/fs;
t=n*dt;                                 % ʱ������
A=0.5;                                  % ��λ���Ʒ�ֵ
x=(1+0.5*cos(2*pi*5*t)).*cos(2*pi*50*t+A*sin(2*pi*10*t));  % �ź�����
z=hilbert(x');                          % ϣ�����ر任
a=abs(z);                               % ������
xL=z.*exp(-1i*2*pi*50*t');              % ��Ч��ͨ�ź�

[Xf, f] = SpectrumViewer(x,fs, 'twosided');   %��ͨ�źŵ�Ƶ��
[Zf, f] = SpectrumViewer(z,fs, 'twosided');   %�����źŵ�Ƶ��
[XLf, f] = SpectrumViewer(xL,fs, 'twosided'); %��Ч��ͨ�źŵ�Ƶ��
% ��ͼ
figure	
subplot(211)
plot(t, x);xlabel('t');ylabel('ʱ�����');title('ʱ���ź�')
subplot(212)
pos = get(gcf,'Position');
set(gcf,'Position',[pos(1), pos(2)-100,pos(3),pos(4)]);
plot(t,x,'k'); hold on;
plot(t,a,'r--','linewidth',2);
title('������'); ylabel('��ֵ'); xlabel(['ʱ��/s' 10 '(a)']);
figure
subplot(311)
plot(f, abs(Xf));xlabel('f');ylabel('������');title('��ͨ�źŵ�Ƶ��')
subplot(312)
plot(f, abs(Zf));xlabel('f');ylabel('������');title('�����źŵ�Ƶ��')
subplot(313)
plot(f, abs(XLf));xlabel('f');ylabel('������');title('��Ч��ͨ�źŵ�Ƶ��')

