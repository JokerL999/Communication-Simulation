% �����ز�����µ�AM����ͨ��ƽ�����ʹ�ͨ�˲���
clearvars; close all;
rng default;

Nsym=1000;                 %������
L=20;                      %����������
M=4;                       %MPAM�ĵ��ƽ���
Ts=.0001;                  %��������
Fs=1/Ts;                   %����Ƶ��

%% �����źŲ���
time=Ts*Nsym*L;            %����ʱ�䳤��
t=Ts:Ts:time;              %����ʱ��ʸ��
d = ceil(M.*rand(1,Nsym)); %�����������
m = mpam_modulator(M,d);   %MPAM����
mup=zeros(1,Nsym*L); 
mup(1:L:Nsym*L)=m;         % ������,ÿ������֮��ΪL-1��0
ps=hamming(L);             % ���ΪL�����岨�Σ���hamming��Ϊ����
s=filter(ps,1,mup);        % ���������岨�ξ��

subplot 311
stem(t(1:10*L),mup(1:10*L))
xlabel('t');ylabel('����');title('�����ź�')
subplot 312
plot(t(1:10*L),s(1:10*L))
xlabel('t');ylabel('����');title('ʱ����')
%% �����ز����ز�����
fc=1000;                   % �ز�Ƶ��
phoff=1.0;                 % ��λ
c=cos(2*pi*fc*t+phoff);    % �����ز��ź�
r=s.*c;                    % �ز����ƣ������ز���
%% �����źŴ���
q=r.^2;                    % ƽ����
n=100;                     % �˲�������
ff=[0 .38 .39 .41 .42 1];  % ��ͨ�˲���������Ƶ��Ϊ2*fc/(Fs/2)=0.4
fa=[0 0 1 1 0 0];          
h=firpm(n,ff,fa);          % ʹ��firpm��ƵĴ�ͨ�˲���
rp=filter(h,1,q);          % ͨ����ͨ�˲���
%% ʹ��FFT�����ź�Ƶ�ʺ���λ
[Xf, f] = SpectrumViewer(rp, Fs, 'onesided');
subplot 313
plot(f, abs(Xf))
xlabel('f[Hz]');ylabel('������');title('Ƶ��')

[m,imax]=max(abs(Xf))              % Ѱ��Ƶ�׵����ֵ
freqS=f(imax)                      % ���ֵ����Ƶ��
phasep=angle(Xf(imax));            % ���ֵ������λ
[IR,f]=freqz(h,1,length(rp),Fs);   % �˲�����Ƶ����Ӧ
[mi,im]=min(abs(f-freqS));         % �ҳ�Ƶ�����ֵ��Ӧ���˲���Ƶ��λ��
phaseBPF=angle(IR(im));            % ��ֵƵ�ʴ����˲�����λ
phaseS=mod(phasep-phaseBPF,pi)     % ���Ƴ�����λ