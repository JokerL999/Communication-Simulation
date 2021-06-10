% Ƶ�ʲ��������FIRʾ��
clear all; clc; close all

Fs=1000;                         % ����Ƶ��
halfFs=Fs/2;                     % �ο�˹��Ƶ��
fp1=150; fp2=170;                % ͨ��Ƶ��
fs1=130; fs2=190;                % ���Ƶ��
deltaw=(fp1-fs1)*pi/halfFs;      % ���ɴ�����
M = ceil(6.6*pi/ deltaw);        % ������������������˲�������N
M = M + mod(M,2);                % ʹ�˲�������Ϊż��
f=[0 fs1 fp1 fp2 fs2 halfFs]/halfFs; % ͨ���������Ƶ�ʵ�黯ֵ
m=[0 0 1 1 0 0];                 % ͨ���������Ƶ�ʵ�黯ֵ

wind = (hamming(M+1))';          % ����������
b=fir2(M,f,m,wind);               % ��fir2�������FIR��1���˲���

% �����˲�����Ƶ����Ӧ
w=0:0.001:pi;                  
H=freqz(b,1,w);                  %�˲�����Ӧ
mag=abs(H);
db=20*log10((mag+eps)/max(mag)); %���ȵ����ֵ 
pha=angle(H);                    %��λ��
grd=grpdelay(b,1,w);             %Ⱥʱ��

subplot 311;
plot(w*Fs/(2*pi),db,'k','linewidth',2);
title('(a)��ͨ�˲����ķ�ֵ��Ӧ');
grid; xlabel('Ƶ��/Hz');  ylabel('��ֵ/dB')
set(gca,'XTickMode','manual','XTick',[0,130,150,170,190])

subplot 312;
plot(w*Fs/(2*pi),pha,'k','linewidth',2);
title('(b)��ͨ�˲�������λ��Ӧ');
grid; xlabel('Ƶ��/Hz');  ylabel('��λ/dB')

subplot 313; stem(1:M+1,b,'k');
xlabel('Ƶ��/Hz');  ylabel('��ֵ/dB')
title('(c)��ͨ�˲�����������Ӧ');
xlabel('����');  ylabel('��ֵ')

