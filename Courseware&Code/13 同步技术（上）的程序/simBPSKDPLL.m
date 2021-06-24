%BPSK�źŵ��ز��ָ�������PLL��
clear,close all,
rng default

Tsym=1;        %��������
Rsym=1/Tsym;   %��������

Fc=4*Rsym;     %��Ƶ
Fsam=5*Fc;     %����Ƶ��
Tsam=1/Fsam;   %��������
L=Tsym/Tsam;   %ÿ���������� 

Nsym=30;       %���������
ds=randi([0 1],1,Nsym)*2-1;         % 1��-1��BPSK��������
dt=reshape(repmat(ds,L,1),1,Nsym*L);
NT=length(ds)*L;                   % ���в�����ĳ���
phi=pi/3 +pi/20*sin([1:NT]*pi/200); % ģ�������ź��б仯����λ 


%��Բ�˲�����ƣ����ɴ�խ��ͨ��������Ȳ��ơ�
fp=Fc/(Fsam/2);
fs=fp*1.2;
Rp=3;    % ͨ������[dB]
As=40;   % ���˥��[dB]
[Norder,fc0]= ellipord(fp,fs,Rp,As);     % �����˲�������[Norder]�ͽ�ֹƵ��[fc0]
[Bde,Ade]= ellip(Norder,Rp,As,fc0);      % ��Բ�˲������
zi_c=zeros(1,max(length(Bde),length(Ade))-1); %��ɽ�����˲���״̬
zi_i=zeros(1,max(length(Bde),length(Ade))-1); %����ɽ�����˲���״̬
zi_e=zeros(1,max(length(Bde),length(Ade))-1); %ģ��LP��ͨ�˲�����״̬

theta=zeros(1,length(NT)); 
mu=0.1;

t=0:Tsam:(NT-1)*Tsam;          % ʱ��ʸ��
s=dt.*cos(2*pi*Fc.*t+phi);     % �����ź�
xin=s.^2;                      % �����ź�ƽ��
e=zeros(1,NT);                                
r_dem_c=zeros(1,NT);          %��ɽ���Ľ������
r_dem_i=zeros(1,NT);          %����ɽ���Ľ������
r_dt_c=zeros(1,NT);           %��ɽ���ָ��Ļ�������
r_dt_i=zeros(1,NT);           %����ɽ���ָ��Ļ�������
for k=1:NT
    e(k)=-xin(k)*sin(4*pi*Fc*t(k)+2*theta(k));    
    [update,zi_e]=filter(Bde,Ade,e(k),zi_e); % ģ��LP����ĵ�ͨ�˲���
    theta(k+1)=theta(k)+mu*update;           % �����½�����
    
    r_dem_c(k)=s(k)*2*cos(2*pi*Fc.*t(k)+theta(k));    % ��ɽ������λ����    
    [r_dt_c(k),zi_c]=filter(Bde,Ade,r_dem_c(k),zi_c); % �˳���Ƶ�������õ������ź�
    
    r_dem_i(k)=s(k)*2*cos(2*pi*Fc.*t(k));             % ����ɽ��������λ����   
    [r_dt_i(k),zi_i]=filter(Bde,Ade,r_dem_i(k),zi_i); % �˳���Ƶ�������õ������ź�
end

figure
subplot(311);
plot(t,phi,'k',t,theta(1:end-1),'r')                             
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
