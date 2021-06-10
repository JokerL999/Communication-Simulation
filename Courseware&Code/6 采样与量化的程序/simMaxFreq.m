clearvars; clc;

%寻找上界
Wmax=1;%最大频率
EngSum=0;%能量
Th=0.99;%设定占比不低于0.99

%如果设定的最大频率以下能量不超过门限，Wmax就乘以2，搜索上界
while (EngSum<Th)
    Wmax=2*Wmax; 
    h=Wmax/100;
    x=h:h:Wmax;
    y=(sin(0.5.*x)./(0.5.*x)).^2./pi;
    y=[1/2/pi y];%第一个元素为w=0的时候能量
    EngSum=sum(y.*h);
end

%找到上界以后，利用二分法，搜索更为核实的Wmax
l=Wmax/2;
u=Wmax;
Wmax=(u+l)/2;
h=Wmax/100;
x=h:h:Wmax;
y=(sin(0.5.*x)./(0.5.*x)).^2./pi;
y=[1/2/pi y];%第一个元素为w=0的时候能量
EngSum=sum(y.*h);
while abs(EngSum-Th)/EngSum>0.001 %控制误差，不超过0.001
    if EngSum>Th
        u=Wmax;
    else
        l=Wmax;
    end
    Wmax=(u+l)/2;
    h=Wmax/100;
    x=h:h:Wmax;
    y=(sin(0.5.*x)./(0.5.*x)).^2./pi;
    y=[1/2/pi y];%第一个元素为w=0的时候能量
    EngSum=sum(y.*h);
end;
fprintf('最大频率为%6.2f[rad],最大采样间隔为%6.2f[ms],...最小采样频率为%6.2f[Hz]\n',...
    Wmax,pi/Wmax*1000,Wmax/pi);

