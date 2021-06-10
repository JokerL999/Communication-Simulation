% �����������FIRʾ��
clear all; clc; close all

Fs=100;                          % ����Ƶ��
halfFs=Fs/2;                     % �ο�˹��Ƶ��
fp=3; fs=5;                      % ͨ�������Ƶ��
Rp=3; As=50;                     % ͨ�����ƺ����˥��
wp = fp*pi/halfFs;               % ͨ����һ����Ƶ��
ws = fs*pi/halfFs;               % �����һ����Ƶ��
deltaw= ws - wp;                 % ���ɴ����صļ���
M = ceil(6.6*pi/ deltaw);        % ������������������˲�������N
M = M + mod(M,2);                % ʹ�˲�������Ϊż��
wind = (hamming(M+1))';          % ����������
Wn=(fp+fs)/Fs;                   % �����ֹƵ��
b=fir1(M,Wn,wind);               % ��fir1�������FIR��1���˲���

% �����˲�����Ƶ����Ӧ
w=0:0.001:pi;                  
H=freqz(b,1,w);                  %�˲�����Ӧ
mag=abs(H);
db=20*log10((mag+eps)/max(mag)); %���ȵ����ֵ 
pha=angle(H);                    %��λ��
grd=grpdelay(b,1,w);             %Ⱥʱ��

% ��ͼ
subplot 311;
plot(w*Fs/(2*pi),db,'k','linewidth',2);
title('(a)��ͨ�˲����ķ�ֵ��Ӧ');
grid; xlabel('Ƶ��/Hz');  ylabel('��ֵ/dB')
set(gca,'XTickMode','manual','XTick',[0,3,5,50])

subplot 312;
plot(w*Fs/(2*pi),pha,'k','linewidth',2);
title('(b)��ͨ�˲�������λ��Ӧ');
grid; xlabel('Ƶ��/Hz');  ylabel('��λ/dB')

subplot 313; stem(1:M+1,b,'k');
xlabel('Ƶ��/Hz');  ylabel('��ֵ/dB')
title('(c)��ͨ�˲�����������Ӧ');
xlabel('����');  ylabel('��ֵ')

