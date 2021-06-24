%���໷����
clear, close all

Tsym=1;        %��������
Rsym=1/Tsym;   %��������

Fc=4*Rsym;     %��Ƶ
Fsam=4*Fc;     %����Ƶ��
Tsam=1/Fsam;   %��������
L=Tsym/Tsam;   %ÿ���������� 

Nsym=30;
NT=Nsym*L; 
tt=[0:NT]*Tsam; % ����ʱ�䷶Χ 0��N_Iter��������

wc=2*pi*Fc;      %�ز���Ƶ��
phi=pi/2 + pi/40*sin(0.01*pi*tt/Tsam);   % ģ�������ź��б仯����λ 

zeta=sqrt(0.5);  %����ϵ��
wn=wc/16;        %��ȻƵ�ʣ�ͨ��С����Ƶ��1/15

% �˲�������
T2=max(2*zeta/wn,Tsam/pi);
T1=10*T2;
Kc=2*wn^2*T1; 
% ����˫���Ա任������ģ��Ļ�·�˲���(T2*s+1)/(T1*s)��ɢ��
% [bLF,aLF]=bilinear([T2 1],[T1 0],1/Tsam,1/T2/2/pi)
[bLF,aLF]=bilinear([T2 1],[T1 0],1/Tsam);
% ����˫���Ա任������VCO (Kv/s)��ɢ��
[bVCO,aVCO]=bilinear(Kc,[1 0],1/Tsam);

% ��ʼ���źſռ�
xin=zeros(1,NT);     %�����ź�
xout=zeros(1,NT);    %VCO����ź�
e=zeros(1,NT);       %PD����ź�
theta=zeros(1,NT);   %��λ�������
slf=zeros(1,NT);     % LF����ź�
ziLF=zeros(1,max(length(aLF),length(bLF))-1);    %����LF�˲���״̬
ziVCO=zeros(1,max(length(aVCO),length(bVCO))-1); %����VCO�˲���״̬

for n=1:NT
   t=tt(n);  
   xin(n)=sin(wc*t+phi(n));     % PLL�����ź�
   xout(n)=cos(wc*t+theta(n));
   e(n)= xin(n)*xout(n);      % ��·�˲����������ź�

  [slf(n+1),ziLF]=filter(bLF,aLF,e(n),ziLF);
  [theta(n+1),ziVCO]= filter(bVCO,aVCO,slf(n+1),ziVCO);% ͨ��VCO�˲����������λ����
end

plot(tt,theta,'r', tt,phi,'k'), box off
xlim(tt([1 end]));
xlabel('ʱ��[s]')
ylabel('��λ[rad]')
title('���໷��λ����')
legend('ʵ����λ','������λ')


