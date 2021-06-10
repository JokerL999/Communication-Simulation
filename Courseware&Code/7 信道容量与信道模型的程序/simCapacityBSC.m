% 仿真计算BSC容量
clearvars; close all; clc
nBits=10^5;           %发送的比特数
errorProbs = 0:0.1:1; %错误概率
C = zeros(1,length(errorProbs)); %存储容量的空间

j=1;
for e=errorProbs 
    x = randi([0,1],1,nBits);
    y = bsc_channel(x,e);  %通过BSC信道
    
    prob00=sum((x==0)&(y==0))/nBits;
    prob01=sum((x==0)&(y==1))/nBits;
    prob10=sum((x==1)&(y==0))/nBits;
    prob11=sum((x==1)&(y==1))/nBits;
    
    prob00=max(prob00,realmin); %避免出现NaN的情况
    prob01=max(prob01,realmin);
    prob10=max(prob10,realmin);
    prob11=max(prob11,realmin);
    
    HYX=(-sum(prob00.*log2(prob00)))+(-sum(prob01.*log2(prob01)))+...
        (-sum(prob10.*log2(prob10)))+(-sum(prob11.*log2(prob11)));
    
    px0 = sum(x==0)/nBits;    % 计算x=0的比率
    px1 = sum(x==1)/nBits;    % 计算x=1的比率
    HX = -px0*log2(px0) - px1*log2(px1); %x的信息量
    
    py0 =sum(y==0)/nBits;      % 计算y=0的比率
    py1 =sum(y==1)/nBits;      % 计算y=1的比率
    HY = -py0*log2(py0) - py1*log2(py1);%y的信息量

    C(j)=HX+HY-HYX;%容量
    j=j+1;
end
plot(errorProbs,C); title('BSC信道容量');
xlabel('错误概率e');
ylabel('容量 (bits/channel use)');
