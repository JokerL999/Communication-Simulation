clf; %图形窗清屏
nf1=0:20; %建立f1的时间向量
f1=0.8.^nf1; %建立f1序列
lf1=length(f1);%取f1时间向量的长度
nf2=0:10; %f2的时间向量
lf2=length(nf2);%取f2时间向量的长度
f2=ones(1,lf2);%建立f2序列
lmax=max(lf2,lf1);%求最长的序列
if lf2>lf1 
    nf2=0;nf1=lf2-lf1;%若f2比f1长,对f1补nf1个0
elseif lf2<lf1 
    nf1=0;nf2=lf1-lf2;%若f1比f2长,对f2补nf2个0
else
    nf2=0;lf1=0; %若f1与f2同长,不补0
end
lt=lmax; %取长者为补0长度基础
%先将f2补得与f1同长,再将两边补最大长度的0
u=[zeros(1,lt),f2,zeros(1,nf2),zeros(1,lt)];
t1=(-lt+1:2*lt);%先将f1补得与f2同长,再将左边补2倍最大长度的0
f1=[zeros(1,2*lt),f1,zeros(1,nf1)];
hf1=fliplr(f1); %将f1作左右反折
N=length(hf1);
y=zeros(1,3*lt); %将y存储单元初始化
for k=0:2*lt %动态演示绘图
    p=[zeros(1,k),hf1(1:N-k)];%使hf1向右循环移位
    y1=u.*p; %使输入和翻转移位的脉冲过渡函数逐项相乘
    yk=sum(y1); %相加
    y(k+lt+1)=yk;%将结果放入数组y
    subplot(4,1,1);stem(t1,u);title('f2信号');axis([-20,50,0,1]);
    subplot(4,1,2);stem(t1,p);title('反折移位的f1');axis([-20,50,0,1]);
    subplot(4,1,3);stem(t1,y1);title('逐项相乘');axis([-20,50,0,1]);
    subplot(4,1,4);stem(k,yk);title('按移位求和')%作图表示每一次卷积的结果
    axis([-20,50,0,5]);
    hold on %在图形窗上保留每一次运行的图形结果
    pause(1); %停顿1秒钟
    
    %---------------------创建gif-------------------------------
    Filename='dynamicconv.gif';%文件名
    f=getframe(gcf);  
    imind=frame2im(f);
    [imind,cm] = rgb2ind(imind,256);
    if k==0 %起始值必须为0，对应循环中k的首个值
        imwrite(imind,cm,Filename,'gif', 'Loopcount',inf ,'DelayTime', 1);%第一次必须创建！
    else
        imwrite(imind,cm,Filename,'gif','WriteMode','append','DelayTime', 1);
    end
    %---------------------创建gif-------------------------------
end

