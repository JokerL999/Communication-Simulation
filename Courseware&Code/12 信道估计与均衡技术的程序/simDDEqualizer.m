%�����о���DD�������Ծ�����ʵ��
clearvars; clc;close all
%rng default

b=[0.5 1 -0.6];              % �����ŵ��弤��Ӧ
Nsym=1000; 
M=2;

d = ceil(M.*rand(Nsym,1));%�����������
s = mpam_modulator(M,d);  %MPAM����
r=filter(b,1,s);             % �ŵ����
n=4;                     
f=[1 0 0 0]';           
mu=.1;                       % �㷨����
for i=n+1:Nsym                 
  rr=r(i:-1:i-n+1)';         
  e=sign(f'*rr)-f'*rr;       
  f=f+mu*conj(e)*rr;               
end

yt=filter(f,1,r);            % ʹ��f������յ����ź�
dec=mpam_detector(M,yt);     % ����о�
for sh=0:n                   % ���������������һ��ʱ���µľ������Ϊ0
  err(sh+1)=0.5*sum(abs(dec(sh+1:Nsym)-d(1:Nsym-sh)'));
end     
err