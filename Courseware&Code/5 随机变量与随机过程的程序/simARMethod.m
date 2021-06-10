%舍选法生成随机变量
clearvars;close all
rng('default') % 初始化种子，可数据重现

n=1e5;%生成数量
f = @(x)x.*exp(-(x.^2)/2);
g = @(x)exp(-x);
grnd = @()exprnd(1); 
X = ARMethod(f,g,grnd,2.2,n,1);

t=0:0.1:10;
t_pdf=f(t);
Y = raylrnd(1,n,1);%MATLAB内置的瑞利分布生成随机变量
subplot(211);histogram(X,'Normalization','pdf');
hold on; plot(t,t_pdf,'m-');hold off;title('舍选法')
xlim([0,5]);legend('仿真','理论');
subplot(212);histogram(Y,'Normalization','pdf');
hold on; plot(t,t_pdf,'m-');hold off;title('MATLAB内置函数')
xlim([0,5]);legend('仿真','理论');

function X = ARMethod(f,g,grnd,c,m,n)
%舍选法实现
% f: f(x)函数定义; g: g(x)函数定义; grnd：概率密度函数为g(x)的随机数生成器
% m，n：随机数维度
    X = zeros(m,n); % 预分配存储空间
    for i = 1:m*n
        accept = false;
        while accept == false
            u = rand(); v = grnd();
            if c*u <= f(v)/g(v)
               X(i) = v;
               accept = true;
            end
        end
    end
end
