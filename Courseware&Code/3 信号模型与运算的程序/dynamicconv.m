clf; %ͼ�δ�����
nf1=0:20; %����f1��ʱ������
f1=0.8.^nf1; %����f1����
lf1=length(f1);%ȡf1ʱ�������ĳ���
nf2=0:10; %f2��ʱ������
lf2=length(nf2);%ȡf2ʱ�������ĳ���
f2=ones(1,lf2);%����f2����
lmax=max(lf2,lf1);%���������
if lf2>lf1 
    nf2=0;nf1=lf2-lf1;%��f2��f1��,��f1��nf1��0
elseif lf2<lf1 
    nf1=0;nf2=lf1-lf2;%��f1��f2��,��f2��nf2��0
else
    nf2=0;lf1=0; %��f1��f2ͬ��,����0
end
lt=lmax; %ȡ����Ϊ��0���Ȼ���
%�Ƚ�f2������f1ͬ��,�ٽ����߲���󳤶ȵ�0
u=[zeros(1,lt),f2,zeros(1,nf2),zeros(1,lt)];
t1=(-lt+1:2*lt);%�Ƚ�f1������f2ͬ��,�ٽ���߲�2����󳤶ȵ�0
f1=[zeros(1,2*lt),f1,zeros(1,nf1)];
hf1=fliplr(f1); %��f1�����ҷ���
N=length(hf1);
y=zeros(1,3*lt); %��y�洢��Ԫ��ʼ��
for k=0:2*lt %��̬��ʾ��ͼ
    p=[zeros(1,k),hf1(1:N-k)];%ʹhf1����ѭ����λ
    y1=u.*p; %ʹ����ͷ�ת��λ��������ɺ����������
    yk=sum(y1); %���
    y(k+lt+1)=yk;%�������������y
    subplot(4,1,1);stem(t1,u);title('f2�ź�');axis([-20,50,0,1]);
    subplot(4,1,2);stem(t1,p);title('������λ��f1');axis([-20,50,0,1]);
    subplot(4,1,3);stem(t1,y1);title('�������');axis([-20,50,0,1]);
    subplot(4,1,4);stem(k,yk);title('����λ���')%��ͼ��ʾÿһ�ξ���Ľ��
    axis([-20,50,0,5]);
    hold on %��ͼ�δ��ϱ���ÿһ�����е�ͼ�ν��
    pause(1); %ͣ��1����
    
    %---------------------����gif-------------------------------
    Filename='dynamicconv.gif';%�ļ���
    f=getframe(gcf);  
    imind=frame2im(f);
    [imind,cm] = rgb2ind(imind,256);
    if k==0 %��ʼֵ����Ϊ0����Ӧѭ����k���׸�ֵ
        imwrite(imind,cm,Filename,'gif', 'Loopcount',inf ,'DelayTime', 1);%��һ�α��봴����
    else
        imwrite(imind,cm,Filename,'gif','WriteMode','append','DelayTime', 1);
    end
    %---------------------����gif-------------------------------
end

