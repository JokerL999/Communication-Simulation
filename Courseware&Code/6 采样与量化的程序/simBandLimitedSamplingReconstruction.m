close all; clearvars; clc;

%% 符号定义函数
syms t
fo=250;
x=@(t)2-cos(2*pi*fo*t)-sin(4*pi*fo*t);
fmax=fo*2;

%% 信号采样与重建
C=0.5;                 %信号的时间区间0~C
fs=3*fmax;             %采样频率fs应大于2fmax，通常是3倍
Ts=1/fs;               %采样时间间隔
Nr=10;                 %信号恢复时，样点之间插入Nf-1个恢复时刻
[~,xs]=sampling(x,C,Ts);  %信号采样
[tr,xx,xr]= sincinterp(xs,1/fs,Nr); %信号恢复

figure
fplot(t,x,[0,6/fo])
hold on
plot(tr(1:floor(6*fs/fo*Nr)),xx(1:floor(6*fs/fo*Nr)),'r'); 
plot(tr(1:floor(6*fs/fo*Nr)),xr(1:floor(6*fs/fo*Nr)),'k'); grid; hold off

legend('原始信号','采样点','恢复信号')
title('带限信号的采样与恢复')

sincinterp_show(xs,Ts,Nr); %展示前3个值的插值

function [t,y]=sampling(f,C,Ts)
  %信号采样函数
  % f 自变量为t的符号函数
  % C 时间范围0~C
  % Ts 采样间隔
  % y  在时间t上信号的采样值
   t=0:Ts:C-Ts;
   y=eval(subs(f,'t',t));
end

function [tr,xx,xr]= sincinterp(x,Ts,Nr)
% Sinc 插值
% x 信号的采样样点
% Ts 信号的采样间隔
% Nr 每个样点插值恢复成Nr个样点输出
% xx和xr为时间范围tr上的原始样点和恢复信号
dT=1/Nr;
N=length(x);
t=0:dT:N-dT;
xr=zeros(1,N*Nr);
kk=2;        % s截断sinc函数，前后取kk*Nr个点
for k=1:N
  %xr=xr+x(k)*sinc(t-(k-1));    
  xr=xr+x(k)*sinc(t-(k-1)).*(heaviside(t-(k-1)+kk/2*Nr)-heaviside(t-(k-1)-kk/2*Nr));    
end
xx(1:Nr:N*Nr)=x(1:N);
xx=[xx zeros(1,Nr-1)];
NN=length(xx);
tr=0:Ts/Nr:NN-1;
end

function sincinterp_show(x,Ts,Nr)
% 展示前3个值的插值
% x 信号的采样样点
% Ts 信号的采样间隔

dT=1/Nr; t=0:dT:3;
m=zeros(1,4);M=m;
x1=x(1)*sinc(t); m(1)=min(x1);M(1)=max(x1);
x2=x(2)*sinc(t-1);m(2)=min(x2);M(2)=max(x2);
x3=x(3)*sinc(t-2);m(3)=min(x3);M(3)=max(x3);
xr1=x1+x2+x3;m(4)=min(xr1);M(4)=max(xr1);
xx1=[x(1) zeros(1,Nr-1) x(2) zeros(1,Nr-1) x(3) zeros(1,Nr)]; NN1=length(xx1);
t1=0:NN1-1;t1=t1*Ts/Nr;
mi=min(m);Ma=max(M);

figure
plot(t1,x1,'m');grid; hold on
plot(t1,x2,'r'); hold on
plot(t1,x3,'g');hold on
stem(t1,xx1,'filled'); hold on
plot(t1,xr1,'k');axis([0 max(t1) 1.5*mi 1.5*Ma]);hold off
legend('第1样点','第2样点','第3样点')
title('前3个值的插值')
end