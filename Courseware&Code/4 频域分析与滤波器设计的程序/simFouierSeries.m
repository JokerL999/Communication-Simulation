% ����Ҷ�����ֽ����ۺ�
clearvars;close all;

%% ��������
t0=0;T=3;
w=2*pi/T;
N=[1,5,10,30];

%% ��������ʱ���ź�
syms t
x=exp(-t);
fplot(x,[t0 t0+T]);

%% ����Ҷ�����ֽ����ۺ�չʾ
for n=N
    [a,xx]=FouierSeries(x,T,n);
    figure
    fplot(xx,[t0 t0+T]);
    titleString=[char(x),'��',num2str(2*n+1),'���Ҷ�������ƽ��'];
    title(titleString)
end

%% ��������
nn=[-n:n];
figure;subplot(211)
stem(nn,abs(a))
titleString=['������ n=',num2str(-n),':',num2str(n)];
title(titleString)
xlabel('n');
subplot(212)
stem(nn,angle(a))
titleString=['��λ�� n=',num2str(-n),':',num2str(n)];
title(titleString)
xlabel('n'); ylabel('rad')