clearvars;close all; 
rng default

Tsym=1;
L=16;     %���������ӣ�ÿ�����ŵ�������Ŀ��
Nsym=100; %���ɷ�����
Nshow=16; %��ͼչʾ�ķ�����
dt=Tsym/L;
FilterSpanSym=6; %�˲�����ȣ��Է���Ϊ��λ������ʱ��,-Nsym/2~Nsym/2��

inBits=2*randi([0,1],1,Nsym)-1; %����˫���������ź�
t=0:1/L:length(inBits)-1/L;
din=repmat(inBits,L,1);
din=reshape(din,1,[]);

dd=sigexpand(inBits,L); %����������
%����ϵͳ�����Ӧ��sinc��������ͨ�˲�����
[ht,~]=sincFunction(L,Tsym,FilterSpanSym);
st=conv(dd,ht);
tt=-FilterSpanSym/2*Tsym:dt:(Nsym+FilterSpanSym/2)*L*dt-dt; %ͨ���˲���������FilterSpanSym/2

subplot(211)
plot(t,din)
xlim([0,Nshow*Tsym])
str=strcat('�����źŲ��Σ�',num2str(inBits(1:Nshow)));
title(str);
subplot(212)
plot(tt,st);
xlim([0,Nshow*Tsym])
xlabel('ʱ�� t/Tsym');
title('�����źŲ���');

function [out]=sigexpand(d,M)% M��������
N=length(d);
out=zeros(M,N);
out(1,:)=d;
out=reshape(out,1,M*N);
end

