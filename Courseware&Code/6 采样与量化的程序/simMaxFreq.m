clearvars; clc;

%Ѱ���Ͻ�
Wmax=1;%���Ƶ��
EngSum=0;%����
Th=0.99;%�趨ռ�Ȳ�����0.99

%����趨�����Ƶ�������������������ޣ�Wmax�ͳ���2�������Ͻ�
while (EngSum<Th)
    Wmax=2*Wmax; 
    h=Wmax/100;
    x=h:h:Wmax;
    y=(sin(0.5.*x)./(0.5.*x)).^2./pi;
    y=[1/2/pi y];%��һ��Ԫ��Ϊw=0��ʱ������
    EngSum=sum(y.*h);
end

%�ҵ��Ͻ��Ժ����ö��ַ���������Ϊ��ʵ��Wmax
l=Wmax/2;
u=Wmax;
Wmax=(u+l)/2;
h=Wmax/100;
x=h:h:Wmax;
y=(sin(0.5.*x)./(0.5.*x)).^2./pi;
y=[1/2/pi y];%��һ��Ԫ��Ϊw=0��ʱ������
EngSum=sum(y.*h);
while abs(EngSum-Th)/EngSum>0.001 %������������0.001
    if EngSum>Th
        u=Wmax;
    else
        l=Wmax;
    end
    Wmax=(u+l)/2;
    h=Wmax/100;
    x=h:h:Wmax;
    y=(sin(0.5.*x)./(0.5.*x)).^2./pi;
    y=[1/2/pi y];%��һ��Ԫ��Ϊw=0��ʱ������
    EngSum=sum(y.*h);
end;
fprintf('���Ƶ��Ϊ%6.2f[rad],���������Ϊ%6.2f[ms],...��С����Ƶ��Ϊ%6.2f[Hz]\n',...
    Wmax,pi/Wmax*1000,Wmax/pi);

