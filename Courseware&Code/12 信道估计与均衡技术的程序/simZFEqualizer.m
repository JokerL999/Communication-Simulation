clearvars; clc;close all

%% ��������
L=5;     %����������,ÿ���ŵ�������Ŀ
Fs=100;  %������
Ts=1/Fs; %��������
Tsym=L*Ts; %��������

%�ŵ����ݺ���
k=6;                            %�ŵ���Ӧ�ķ��ſ�ȣ�-k*Tsym~k*Tsym��
N0 = 0.01;                      %AWGN�ŵ�������׼����
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

%% ZF����������Ƶ����Ӧ
%��������Ʋ���
nTaps = 14;          %FIR�˲�����ͷ��Ŀ
[h_eq,error,optDelay]=zf_equalizer(h_c,nTaps);
xn=h_c; 
h_sys=conv(h_eq,h_c); %�ŵ��;����˲���������ЧӦ

%Ƶ����Ӧ���ŵ���ZF������������ЧӦ 
[H_c,W]=freqz(h_c);    
[H_eq,W]=freqz(h_eq);   
[H_sys,W]=freqz(h_sys); 

%Ƶ����Ӧ��ͼ
figure; plot(W/pi,20*log10(abs(H_c)/max(abs(H_c))),'g'); hold on; 
plot(W/pi,20*log10(abs(H_eq)/max(abs(H_eq))),'r'); 
plot(W/pi,20*log10(abs(H_sys)/max(abs(H_sys))),'k');
legend('�ŵ�','ZF������','����ЧӦ');
title('Ƶ����Ӧ'); ylabel('���� (dB)');
xlabel('��һ��Ƶ�� (x \pi rad/sample)');


%% ZF������ʱ��Ӱ��
figure; 
subplot(1,2,1); stem(0:1:length(xn)-1,xn); title('����������'); 
xlabel('����'); ylabel('����');

subplot(1,2,2); stem(0:1:length(h_sys)-1,h_sys);
title(['���������- N=', num2str(nTaps),...
    ' ʱ��=',num2str(optDelay), ' ���=', num2str(error)]); 
xlabel('����'); ylabel('����');