close all; clearvars; clc;

%% ���Ŷ��庯��
syms t
fo=250;
x=@(t)2-cos(2*pi*fo*t)-sin(4*pi*fo*t);
fmax=fo*2;

%% �źŲ������ؽ�
C=0.5;                 %�źŵ�ʱ������0~C
fs=3*fmax;             %����Ƶ��fsӦ����2fmax��ͨ����3��
Ts=1/fs;               %����ʱ����
Nr=10;                 %�źŻָ�ʱ������֮�����Nf-1���ָ�ʱ��
[~,xs]=sampling(x,C,Ts);  %�źŲ���
[tr,xx,xr]= sincinterp(xs,1/fs,Nr); %�źŻָ�

figure
fplot(t,x,[0,6/fo])
hold on
plot(tr(1:floor(6*fs/fo*Nr)),xx(1:floor(6*fs/fo*Nr)),'r'); 
plot(tr(1:floor(6*fs/fo*Nr)),xr(1:floor(6*fs/fo*Nr)),'k'); grid; hold off

legend('ԭʼ�ź�','������','�ָ��ź�')
title('�����źŵĲ�����ָ�')

sincinterp_show(xs,Ts,Nr); %չʾǰ3��ֵ�Ĳ�ֵ

function [t,y]=sampling(f,C,Ts)
  %�źŲ�������
  % f �Ա���Ϊt�ķ��ź���
  % C ʱ�䷶Χ0~C
  % Ts �������
  % y  ��ʱ��t���źŵĲ���ֵ
   t=0:Ts:C-Ts;
   y=eval(subs(f,'t',t));
end

function [tr,xx,xr]= sincinterp(x,Ts,Nr)
% Sinc ��ֵ
% x �źŵĲ�������
% Ts �źŵĲ������
% Nr ÿ�������ֵ�ָ���Nr���������
% xx��xrΪʱ�䷶Χtr�ϵ�ԭʼ����ͻָ��ź�
dT=1/Nr;
N=length(x);
t=0:dT:N-dT;
xr=zeros(1,N*Nr);
kk=2;        % s�ض�sinc������ǰ��ȡkk*Nr����
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
% չʾǰ3��ֵ�Ĳ�ֵ
% x �źŵĲ�������
% Ts �źŵĲ������

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
legend('��1����','��2����','��3����')
title('ǰ3��ֵ�Ĳ�ֵ')
end