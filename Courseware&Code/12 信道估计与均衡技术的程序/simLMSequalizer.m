%LMS������ʵ��
clearvars; clc;close all
%rng default

b=[0.5 j -0.6];           % �����ŵ��弤��Ӧ
M=2;                      % ���ƽ���    
Nsym=10000;                % ����ķ�����Ŀ
d = ceil(M.*rand(1,Nsym));%�����������
s = mpam_modulator(M,d);  %MPAM����
r=filter(b,1,s);          % �ŵ����
n=4;                      % ����������
mu=.0001;                   % ���� 
delta=2;                  % ʱ�� delta,�ź�ͨ���˲�����ʱ��

f =lms_equalizer(n,mu,r,d,delta); % ����LMS��������ͷϵ��
yt=filter(f,1,r);            % ʹ��f������յ����ź�
dec=mpam_detector(M,yt);     % ����о�
for sh=0:n                   % ���������������һ��ʱ���µľ������Ϊ0
  err(sh+1)=sum(abs(dec(sh+1:Nsym)-d(1:Nsym-sh)));
end                          
err