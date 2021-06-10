close all; clearvars; clc;

%%参考文献
% https://www.gaussianwaves.com/2011/07/sampling-theorem-bandpass-or-intermediate-or-under-sampling-2/
% Meng Xiangwei, "Sampling and reconstruction of bandpass signal," Proceedings of Third International Conference on Signal Processing (ICSP'96), Beijing, 1996, pp. 80-82 vol.1.

%% 符号定义信号
syms t
fo=10;                    %基带正弦信号的频率
fc=1e3;                   %载频

fmax=fo*3;
fL=fc-fmax;
fH=fc+fmax;
xm=@(t)2*cos(2*pi*fo*t)+sin(4*pi*fo*t); %基带信号
xc=@(t)xm*cos(2*pi*fc*t);               %带通信号

%% 基带生成与展示
C=1;                             %信号的时间区间0~C[秒]
fs=100*fmax;                     %用于画基带信号的采样率
Ts=1/fs;
[t,ym]=sampling(xm,C,Ts);        %信号采样
[Yfm, ffm] = SpectrumCalc(ym, fs);
figure
subplot(231)
plot(t, ym)
xlabel('t')
ylabel('y')
title('基带信号')
subplot(234)
plot(ffm, abs(Yfm))
xlabel('f')
ylabel('|Yf|')
title('基带信号频谱')
xlim([0 50])

%% 带通信号生成与展示
fs=10*fc;
Ts=1/fs;
[tPass, ycPass]=sampling(xc,C,Ts);  %信号采样
[Yfo, ffo] = SpectrumCalc(ycPass, fs);
subplot(232)
plot(tPass, ycPass)
xlabel('t')
ylabel('y')
title('带通信号')
xlim([0,0.2])
subplot(235)
plot(ffo, abs(Yfo))
xlabel('f')
ylabel('|Yf|')
xlim([fL fH])
% ylim([0 1])
title('带通信号频谱')


%% 带通信号采样
n=0;
while(2*(fL+fH)/(2*n+1)>2*(fH-fL))
    n=n+1;
end
n=n-1;
fs=2*(fL+fH)/(2*n+1);
m=floor(2*fL/fs);
fprintf('采样频率为%6.3f[Hz]\n',fs);

% fs=2.1*(fH-fL);
Ts=1/fs;                              %用于画带通信号的采样率
[t, ys]=sampling(xc,C,Ts);            %信号采样
[Yf, f] = SpectrumCalc(ys, fs);

subplot(236)
plot(f, abs(Yf))
xlabel('f')
ylabel('|Yf|')
%xlim([0 100])
%ylim([0 1])
title('采样信号频谱')


%% 带通信号恢复
Nr=100;                 %信号恢复时，样点之间插入Nf-1个恢复时刻
[tr,xx,xr]= sincinterp(ys,1/fs,fc,Nr);

subplot(233);
hold on
plot(tr,xx,'r'); 
grid; hold off
title('采样点');xlim([0,0.2]);
%注意：恢复信号幅度为原来一半，时因为调制的原因。

figure 
subplot(311)
plot(tPass, ycPass);xlim([0 0.2]);grid; 
title('原信号')
subplot(312)
plot(tr-Ts,xr);xlim([0 0.2]);grid; %平移了Ts
title('恢复信号')
subplot(313);
fs=Nr*fs;
Ts=1/fs;                              %用于画带通信号的采样率
[Yf, f] = SpectrumCalc(xr, fs);
plot(f, Yf)
xlabel('f')
ylabel('|Yf|')
xlim([fL fH])
title('恢复信号频谱')

%% 支持函数
function [t,y]=sampling(f,C,Ts)
  %信号采样函数
  % f 自变量为t的符号函数
  % C 时间范围0~C
  % Ts 采样间隔
  % y  在时间t上信号的采样值
   t=0:Ts:C-Ts;
   y=eval(subs(f,'t',t));
end

function [tr,xx,xr]= sincinterp(x,Ts,fc,Nr)
% Sinc 插值
% x 信号的采样样点
% Ts 信号的采样间隔
% xx和xr为时间范围tr上的原始样点和恢复信号
dT=Ts/Nr;   
N=length(x);
t=0:dT:N*Ts-dT;   
xr=zeros(1,length(t));
kk=3;        % s截断sinc函数，前后取kk*Nr个点
for k=1:N
     xr = xr + x(k)*sinc((t-k*Ts)/(2*Ts)).*cos(2*pi*fc*(t-k*Ts))...
         .*(heaviside(t-(k-1)+kk/2*Nr)-heaviside(t-(k-1)-kk/2*Nr)); 
end
xx(1:Nr:N*Nr)=x(1:N);
xx=[xx zeros(1,Nr-1)];
tr=t;
end

