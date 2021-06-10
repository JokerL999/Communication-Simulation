% ��FFT��һ�������źŽ���Ƶ�׷���
clear all; clc; close all;

fs=100;                          % ����Ƶ��
N=100;                           % �źų���
t=(0:N-1)/fs;                    % ����ʱ������
f1=25;                           % �ź�Ƶ��

x=0.8+2*cos(2*pi*f1*t+pi/6);       % �źŲ���
X=fft(x);                        % FFT

% ������
Y=zeros(1,N);
freq=(0:N/2-1)*fs/N;             % ����Ƶ�ʿ̶�
Y(1)=abs(X(1))/N;                % ֱ�������ķ��ȵ���
Y(2:end)=abs(X(2:end))*2/N;      % �����ֵ
Theta=angle(X);                  % ������λ

%������λ����
Th=0.1;                        % ������ֵ
thetadex=find(Y<Th);          % Ѱ��С����ֵ���������ߵ�����
Theta(thetadex)=0;            % ����С����ֵ���������߳�ʼ��λ��Ϊ0

subplot 221; plot(freq,Y(1:N/2),'k');  
xlabel('Ƶ��/Hz'); ylabel('��ֵ'); title('������');
subplot 223; plot(freq,Theta(1:N/2),'k');
xlabel('Ƶ��/Hz'); ylabel('��ʼ��/����'); title('��λ');

% ˫����
freq=(0:N-1)*fs/N-fs/2;                % ����Ƶ�ʿ̶�
Y=fftshift(abs(X)/N);                  % �����ֵ
subplot 222; plot(freq,Y,'k');  
xlabel('Ƶ��/Hz'); ylabel('��ֵ'); title('˫����');
subplot 224; plot(freq,Theta,'k');
xlabel('Ƶ��/Hz'); ylabel('��ʼ��/����'); title('��λ');