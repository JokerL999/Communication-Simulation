% 傅里叶级数分解与综合
clearvars;close all;

%% 参数设置
t0=0;T=3;
w=2*pi/T;
N=[1,5,10,30];

%% 周期连续时间信号
syms t
x=exp(-t);
fplot(x,[t0 t0+T]);

%% 傅里叶级数分解与综合展示
for n=N
    [a,xx]=FouierSeries(x,T,n);
    figure
    fplot(xx,[t0 t0+T]);
    titleString=[char(x),'的',num2str(2*n+1),'项傅里叶级数近似结果'];
    title(titleString)
end

%% 绘制线谱
nn=[-n:n];
figure;subplot(211)
stem(nn,abs(a))
titleString=['幅度谱 n=',num2str(-n),':',num2str(n)];
title(titleString)
xlabel('n');
subplot(212)
stem(nn,angle(a))
titleString=['相位谱 n=',num2str(-n),':',num2str(n)];
title(titleString)
xlabel('n'); ylabel('rad')