clearvars; clc;close all
rng default

%% ��������
L=5;     %����������,ÿ���ŵ�������Ŀ
Fs=100;  %������
Ts=1/Fs; %��������
Tsym=L*Ts; %��������

%�ŵ����ݺ���
k=6;                            %�ŵ���Ӧ�ķ��ſ�ȣ�-k*Tsym~k*Tsym��
N0 = 0.1;                       %AWGN�ŵ�������׼����
t = -k*Tsym:Ts:k*Tsym;          %ʱ��ʸ��
h = 1./(1+(t/Tsym).^2);         %�����ŵ�ģ��
h = h + N0*randn(1,length(h));  %��������
h_c= h(1:L:end);                %�²������ﵽ���Ų�����
t_inst=t(1:L:end);              %�²������ʱ��ʸ��

figure;
plot(t,h);            %�����������Ӳ������ŵ���Ӧ
hold on;
stem(t_inst,h_c,'r'); %�����Ų����ʲ������ŵ���Ӧ
hold off
legend('�ŵ���Ӧ','���Ų������µ��ŵ���Ӧ');
title('�����ŵ���ʱ��弤��Ӧ');
xlabel('ʱ��(s)');ylabel('����');

%% MMSE����������Ƶ����Ӧ
%��������Ʋ���
nTaps = 14;          %FIR�˲�����ͷ��Ŀ
snr = 10*log10(1/N0^2); % �źŹ��ʣ�����Ϊ1��/�������ʣ�ת��ΪSNR[dB] 
[h_eq,MSE,optDelay]=mmse_equalizer(h_c,snr,nTaps);
xn=h_c; 
h_sys=conv(h_eq,h_c); %�ŵ��;����˲���������ЧӦ

disp(['MMSE���������: N=', num2str(nTaps), ' Delay=',num2str(optDelay)])
disp('MMSE������Ȩ��:'); disp(h_eq)

%% MMSE������ʱ��Ӱ��
figure; 
subplot(1,2,1); stem(0:1:length(xn)-1,xn); title('����������'); 
xlabel('����'); ylabel('����');

subplot(1,2,2); stem(0:1:length(h_sys)-1,h_sys);
title(['�����������N=', num2str(nTaps),' ʱ��=',num2str(optDelay)]); 
xlabel('����'); ylabel('����');