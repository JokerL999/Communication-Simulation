%�ŵ���Ƶ����Ƶ��Ӱ��ʾ�⣬
close all; clearvars; clc;
rng default
 
%% ��������
Tsym=1;                    %ÿ����������
L = 8;                     %ÿ����Ԫ�ĳ�������
Tsam = Tsym/L;             %����ʱ����
Fs=1/Tsam;                 %����Ƶ��
Nsym= 50;                  %���ݵ���Ԫ����

%% ���ݲ���
gt = ones(1,L);                     %NRZ�ǹ��㲨�� 
t = 0:Tsam:(Nsym*L-1)*Tsam;         %�����Ӧ��ʱ��ʸ��
d = 2*randi([0,1],1,Nsym)-1;        %˫��������Դ
data = INSERT0(d,L);                %�����м������N_sample-1��0 
xt=filter(gt,1,data);               %��Դ����
[Xf, f] = SpectrumViewer(xt,Fs, 'twosided');   % ���㷢�Ͳ��ε�Ƶ��
subplot(211)
plot(t, xt);xlabel('t');ylabel('ʱ�����');title('ʱ���ź�')
axis([0,20,-1.2 1.2]);grid on;
subplot(212)
plot(f, abs(Xf));xlabel('f[Hz]');ylabel('������');title('�����źŵ�Ƶ��')

N = 128;                             %�ŵ����ݺ�����Ƶ�������
f=floor(-N/2+0.5:N/2-0.5)*Fs/N;      %�ŵ����ݺ�����Ƶ�������Ƶ��ʸ�� 
%% �ŵ�1����ʧ���ŵ�
hf1 = exp(-1j*2*pi*f);          % ��ʧ���ŵ���Ƶ����Ӧ��ʱ���ӳ�1��
[ht1,~] = SignalRecoveryFromSpectrum(hf1,f);          % ��Ƶ�׵õ�ʱ����Ӧ
yt1 = filter(ht1,1,xt);         % �˲�

figure
subplot 311
yyaxis left
plot(f,abs(hf1));ylabel('��Ƶ����');ylim([0.5,1.5])
yyaxis right
plot(f,angle(hf1)/pi);
ylabel('��Ƶ����');title('������ʧ���ŵ��ķ�Ƶ����Ƶ����');
grid on;
subplot 312
plot(t,xt(1:Nsym*L));
axis([0,20,-1.2 1.2]);grid on;
title('�����źŲ���')
subplot 313
plot(t,real(yt1(1:Nsym*L)));
title('�����ŵ��������ź�');
axis([0,20,-1.2 1.2]);grid on;
title('����źŲ���')

%% �ŵ�2����Ƶʧ���ŵ�
hf2 = sinc(f).*exp(-1i*pi*f);
[ht2,~] = SignalRecoveryFromSpectrum(hf2,f);        % ��Ƶ�׵õ�ʱ����Ӧ
yt2 = filter(ht2,1,xt);       % �˲�

figure
subplot 311
yyaxis left
plot(f,abs(hf2))
ylabel('��Ƶ����');
ylim([0,1])
yyaxis right
plot(f,angle(hf2)/pi);
ylabel('��Ƶ����');title('��Ƶʧ���ŵ��ķ�Ƶ����Ƶ����');
grid on;
subplot 312
plot(t,xt(1:Nsym*L));
axis([0,20,-1.2 1.2]);grid on;
title('�����źŲ���')
subplot 313
plot(t,real(yt2(1:Nsym*L)));
title('�����ŵ��������ź�');
axis([0,20,-1.2 1.2]);grid on;
title('����źŲ���')

%% �ŵ�3����λʧ���ŵ�
f1 = find(f<0); 
hf3 = exp(-1i*pi*f+1i*pi );
hf3(f1) = exp( -1i*pi*f(f1)-1i*pi );
[ht3,~] = SignalRecoveryFromSpectrum(hf3,f);          % ��Ƶ�׵õ�ʱ����Ӧ
yt3 = filter(ht3,1,xt);       % �˲�

figure
subplot 311
yyaxis left 
plot(f,abs(hf3))
ylabel('��Ƶ����');
ylim([0,2])
yyaxis right
plot(f,angle(hf3)/pi);
ylabel('��Ƶ����');title('��λʧ���ŵ��ŵ��ķ�Ƶ����Ƶ����');
grid on;
subplot 312
plot(t,xt(1:Nsym*L));
axis([0,20,-1.2 1.2]);grid on;
title('�����źŲ���')
subplot 313
plot(t,real(yt3(1:Nsym*L)));
title('�����ŵ��������ź�');
axis([0,20,-1.2 1.2]);grid on;
title('����źŲ���')

%% �ŵ�4����Ƶ��Ⱥʱ��ʧ���ŵ�
hf4 = exp(-1i*pi*f.*f-1i*pi*f+1i*pi);
[ht4,~] = SignalRecoveryFromSpectrum(hf4,f);          % ��Ƶ�׵õ�ʱ����Ӧ
yt4 = filter(ht4,1,xt);       % �˲�

figure
subplot 311
yyaxis left 
plot(f,abs(hf4))
ylabel('��Ƶ����');
ylim([0,2])
yyaxis right
plot(f,angle(hf4)/pi);
ylabel('��Ƶ����');title('��λʧ���ŵ��ŵ��ķ�Ƶ����Ƶ����');
grid on;
subplot 312
plot(t,xt(1:Nsym*L));
axis([0,20,-1.2 1.2]);grid on;
title('�����źŲ���')
subplot 313
plot(t,real(yt4(1:Nsym*L)));
title('�����ŵ��������ź�');
axis([0,20,-1.2 1.2]);grid on;
title('����źŲ���')