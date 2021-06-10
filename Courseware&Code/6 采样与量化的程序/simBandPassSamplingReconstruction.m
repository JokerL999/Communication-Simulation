close all; clearvars; clc;

%%�ο�����
% https://www.gaussianwaves.com/2011/07/sampling-theorem-bandpass-or-intermediate-or-under-sampling-2/
% Meng Xiangwei, "Sampling and reconstruction of bandpass signal," Proceedings of Third International Conference on Signal Processing (ICSP'96), Beijing, 1996, pp. 80-82 vol.1.

%% ���Ŷ����ź�
syms t
fo=10;                    %���������źŵ�Ƶ��
fc=1e3;                   %��Ƶ

fmax=fo*3;
fL=fc-fmax;
fH=fc+fmax;
xm=@(t)2*cos(2*pi*fo*t)+sin(4*pi*fo*t); %�����ź�
xc=@(t)xm*cos(2*pi*fc*t);               %��ͨ�ź�

%% ����������չʾ
C=1;                             %�źŵ�ʱ������0~C[��]
fs=100*fmax;                     %���ڻ������źŵĲ�����
Ts=1/fs;
[t,ym]=sampling(xm,C,Ts);        %�źŲ���
[Yfm, ffm] = SpectrumCalc(ym, fs);
figure
subplot(231)
plot(t, ym)
xlabel('t')
ylabel('y')
title('�����ź�')
subplot(234)
plot(ffm, abs(Yfm))
xlabel('f')
ylabel('|Yf|')
title('�����ź�Ƶ��')
xlim([0 50])

%% ��ͨ�ź�������չʾ
fs=10*fc;
Ts=1/fs;
[tPass, ycPass]=sampling(xc,C,Ts);  %�źŲ���
[Yfo, ffo] = SpectrumCalc(ycPass, fs);
subplot(232)
plot(tPass, ycPass)
xlabel('t')
ylabel('y')
title('��ͨ�ź�')
xlim([0,0.2])
subplot(235)
plot(ffo, abs(Yfo))
xlabel('f')
ylabel('|Yf|')
xlim([fL fH])
% ylim([0 1])
title('��ͨ�ź�Ƶ��')


%% ��ͨ�źŲ���
n=0;
while(2*(fL+fH)/(2*n+1)>2*(fH-fL))
    n=n+1;
end
n=n-1;
fs=2*(fL+fH)/(2*n+1);
m=floor(2*fL/fs);
fprintf('����Ƶ��Ϊ%6.3f[Hz]\n',fs);

% fs=2.1*(fH-fL);
Ts=1/fs;                              %���ڻ���ͨ�źŵĲ�����
[t, ys]=sampling(xc,C,Ts);            %�źŲ���
[Yf, f] = SpectrumCalc(ys, fs);

subplot(236)
plot(f, abs(Yf))
xlabel('f')
ylabel('|Yf|')
%xlim([0 100])
%ylim([0 1])
title('�����ź�Ƶ��')


%% ��ͨ�źŻָ�
Nr=100;                 %�źŻָ�ʱ������֮�����Nf-1���ָ�ʱ��
[tr,xx,xr]= sincinterp(ys,1/fs,fc,Nr);

subplot(233);
hold on
plot(tr,xx,'r'); 
grid; hold off
title('������');xlim([0,0.2]);
%ע�⣺�ָ��źŷ���Ϊԭ��һ�룬ʱ��Ϊ���Ƶ�ԭ��

figure 
subplot(311)
plot(tPass, ycPass);xlim([0 0.2]);grid; 
title('ԭ�ź�')
subplot(312)
plot(tr-Ts,xr);xlim([0 0.2]);grid; %ƽ����Ts
title('�ָ��ź�')
subplot(313);
fs=Nr*fs;
Ts=1/fs;                              %���ڻ���ͨ�źŵĲ�����
[Yf, f] = SpectrumCalc(xr, fs);
plot(f, Yf)
xlabel('f')
ylabel('|Yf|')
xlim([fL fH])
title('�ָ��ź�Ƶ��')

%% ֧�ֺ���
function [t,y]=sampling(f,C,Ts)
  %�źŲ�������
  % f �Ա���Ϊt�ķ��ź���
  % C ʱ�䷶Χ0~C
  % Ts �������
  % y  ��ʱ��t���źŵĲ���ֵ
   t=0:Ts:C-Ts;
   y=eval(subs(f,'t',t));
end

function [tr,xx,xr]= sincinterp(x,Ts,fc,Nr)
% Sinc ��ֵ
% x �źŵĲ�������
% Ts �źŵĲ������
% xx��xrΪʱ�䷶Χtr�ϵ�ԭʼ����ͻָ��ź�
dT=Ts/Nr;   
N=length(x);
t=0:dT:N*Ts-dT;   
xr=zeros(1,length(t));
kk=3;        % s�ض�sinc������ǰ��ȡkk*Nr����
for k=1:N
     xr = xr + x(k)*sinc((t-k*Ts)/(2*Ts)).*cos(2*pi*fc*(t-k*Ts))...
         .*(heaviside(t-(k-1)+kk/2*Nr)-heaviside(t-(k-1)-kk/2*Nr)); 
end
xx(1:Nr:N*Nr)=x(1:N);
xx=[xx zeros(1,Nr-1)];
tr=t;
end

