% ˫���Էǹ��������Ĳ��κ͹����׷���

clear all;
close all;
rng('default');

Nb=10000;             %������ı�����Ŀ
Rb=2;                 %���ݴ�������bit/s
L=10;                 %��������߱���
fs=L*Rb;              %����Ƶ��
inBits=randi([0,1],1,Nb);  %��������

[x,t]=PolNRZ_Coder(inBits,Rb,fs); %�����Էǹ��������

Nshow=10;             %չʾ��bit��Ŀ
plot(t(1:Nshow*L),x(1:Nshow*L));
xlabel('ʱ��[s]')
ylabel('����')
ylim([-1.1,1.1])
str=strcat('˫���Էǹ����룺',num2str(inBits(1:Nshow)));
title(str);

figure
N=length(x);
% [Pxx,f]=periodogram(x,rectwin(N),N,fs); 
% plot(f,pow2db(Pxx));
[pxx,f] = pwelch(x,[],[],[],fs);
plot(f,pow2db(pxx));

Tb=1/Rb;
f=0:0.05*Rb:5*Rb;
Pt=Tb*(sinc(f*Tb).*sinc(f*Tb));
hold on

plot(f,pow2db(Pt),'r')
ylim([-80,40])
grid on
xlabel('Ƶ��[Hz]')
ylabel('�������ܶ�[dBW/Hz]')
legend('��ֵ����','���۷���')
title('˫���Էǹ��������Ĺ�����')


function [output,t]=PolNRZ_Coder(in,Rb,fs)
%˫���Էǹ����������
%in �����������
%Rb �������ʣ�bit/��
%fs ������,��/��

%output �������
% t     �����Ӧ��ʱ��

t=0:1/fs:length(in)-1/fs;

L=floor(fs/Rb);
x=sign(in-0.5);
x=repmat(x,L,1);
output=reshape(x,1,[]);
end
