% ���ŵȲ��Ʒ����FIRʾ��
clear all; clc; close all;

Fs=2000;                          % ����Ƶ��
halfFs=Fs/2;                      % �ο�˹��Ƶ��
fp=200; fs=300;                   % ͨ�������Ƶ��
wp=fp*pi/halfFs; ws=fs*pi/halfFs; % ͨ���������һ����Ƶ��
Rp=2; As=40;                      % ͨ�����ƺ����˥��
F=[wp ws]/pi;                     % �����˲�����Ƶ��ʸ��
A=[1,0];                          % �����˲����ķ�ֵʸ��

% ͨ�����ƺ����˥������ֵ
dev1=(1-10^(-Rp/20))/(1+10^(-Rp/20)); dev2=10^(-As/20); %ͨ�������ƫ��
dev=[dev1,dev2];                  % �������˲�����ƫ���ʸ��

[N,F0,A0,W]=firpmord(F,A,dev);    % ����firpmord�����������
N=N+mod(N,2);                     % ��֤�˲�������Ϊż��
b=firpm(N,F0,A0,W);               % ��firpm��������˲���

% �����˲���Ƶ����Ӧ
w=0:0.001:pi;                  
H=freqz(b,1,w);                  %�˲�����Ӧ
mag=abs(H);
db=20*log10((mag+eps)/max(mag)); %���ȵ����ֵ 
pha=angle(H);                    %��λ��
grd=grpdelay(b,1,w);             %Ⱥʱ��

% ��ͼ
subplot 211; plot(w/pi*halfFs,db,'k','linewidth',2); 
title('�Ȳ����˲�����ֵ��Ӧ'); 
grid;xlabel('Ƶ��/kHz'); ylabel('��ֵ/dB')
set(gca,'XTickMode','manual','XTick',[0,fp,fs,halfFs])
set(gca,'YTickMode','manual','YTick',[-40,0])
subplot 212; stem(0:N,b,'k'); axis([-1,N,-0.1,0.3]); grid;
title('�˲���������Ӧ');xlabel('����'); ylabel('��ֵ');
