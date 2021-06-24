%BPSK�źŵ��ز��ָ���PLL��
clear,close all,
rng default

Tsym=1;        %��������
Rsym=1/Tsym;   %��������

Fc=4*Rsym;     %��Ƶ
Fsam=5*Fc;     %����Ƶ��
Tsam=1/Fsam;   %��������
L=Tsym/Tsam;   %ÿ���������� 

Nsym=30;       %���������
ds=randi([0 1],1,Nsym)*2-1;           % 1��-1��BPSK��������
dt=reshape(repmat(ds,L,1),1,Nsym*L);
NT=length(ds)*L;                      % ���в�����ĳ���
phi=pi +pi/20*sin(0.1*[1:NT]*2*pi); % ģ�������ź��б仯����λ 

%��Բ�˲�����ƣ����ɴ�խ��ͨ��������Ȳ��ơ�
fp=Fc/(Fsam/2);
fs=fp*1.2;
Rp=3;    % ͨ������[dB]
As=40;   % ���˥��[dB]
[Norder,fc0]= ellipord(fp,fs,Rp,As);     % �����˲�������[Norder]�ͽ�ֹƵ��[fc0]
[Bde,Ade]= ellip(Norder,Rp,As,fc0);      % ��Բ�˲������
zi_c=zeros(1,max(length(Bde),length(Ade))-1); %��ɽ�����˲���״̬
zi_i=zeros(1,max(length(Bde),length(Ade))-1); %����ɽ�����˲���״̬

zeta=0.707;  %����ϵ��
wn=2*2*pi*Fc/16;    %��ȻƵ�ʣ�ͨ��С����Ƶ��1/15
% PLL�˲�������
T2=max(2*zeta/wn,Tsam/pi);
T1=10*T2;
Kc=2*wn^2*T1; 
% ����˫���Ա任������ģ��Ļ�·�˲���(T2*s+1)/(T1*s)��ɢ��
% [bLF,aLF]=bilinear([T2 1],[T1 0],1/Tsam,1/T2/2/pi)
[bLF,aLF]=bilinear([T2 1],[T1 0],1/Tsam);
% ����˫���Ա任������VCO (Kv/s)��ɢ��
[bVCO,aVCO]=bilinear(Kc,[1 0],1/Tsam);

t=0:Tsam:(NT-1)*Tsam;          % ʱ��ʸ��
s=dt.*cos(2*pi*Fc.*t+phi);     % �����ź�
xin=s.^2;                      % �����ź�ƽ��

ziLF=zeros(1,max(length(aLF),length(bLF))-1);    %����LF�˲���״̬
ziVCO=zeros(1,max(length(aVCO),length(bVCO))-1); %����VCO�˲���״̬

e=zeros(1,NT);                %LF�����ź�
theta_2=zeros(1,NT);          %������λ����
theta=zeros(1,NT);            %��λ����
slf=zeros(1,NT);              %LF������ź�
r_dem_c=zeros(1,NT);          %��ɽ���Ľ������
r_dem_i=zeros(1,NT);          %����ɽ���Ľ������
r_dt_c=zeros(1,NT);           %��ɽ���ָ��Ļ�������
r_dt_i=zeros(1,NT);           %����ɽ���ָ��Ļ�������
for k=1:NT
    e(k)=xin(k).*sin(2*pi*2*Fc.*t(k)+theta_2(k));        
    [slf(k+1),ziLF]=filter(bLF,aLF,e(k),ziLF);
    [theta_2(k+1),ziVCO]= filter(bVCO,aVCO,slf(k+1),ziVCO);% ͨ��VCO�˲����������λ����       
    
    theta(k)=(theta_2(k)-pi/2)/2;                     % ����-90�㣬�ٶ���Ƶ
    
    r_dem_c(k)=s(k)*2*cos(2*pi*Fc.*t(k)+theta(k));    % ��ɽ��������λ����    
    [r_dt_c(k),zi_c]=filter(Bde,Ade,r_dem_c(k),zi_c); % �˳���Ƶ�������õ������ź�    
    r_dem_i(k)=s(k)*2*cos(2*pi*Fc.*t(k));             % ����ɽ��������λ����   
    [r_dt_i(k),zi_i]=filter(Bde,Ade,r_dem_i(k),zi_i); % �˳���Ƶ�������õ������ź�
end

figure
subplot(311);
plot(t,phi,'k',t,theta,'r')                             
title('��λ����')
xlabel('ʱ��'); ylabel('��λ')
legend('��ʵ��λ','������λ')
subplot(312);
plot(t,dt,'k', t,r_dt_i,'r')
title('����ɽ�����������λ����');
xlabel('ʱ��')
ylabel('����')
subplot(313);
plot(t,dt,'k', t,r_dt_c,'r')
xlabel('ʱ��')
ylabel('����')
title('��ɽ�����������λ����')
