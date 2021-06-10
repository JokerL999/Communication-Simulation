% �������BSC����
clearvars; close all; clc
nBits=10^5;           %���͵ı�����
errorProbs = 0:0.1:1; %�������
C = zeros(1,length(errorProbs)); %�洢�����Ŀռ�

j=1;
for e=errorProbs 
    x = randi([0,1],1,nBits);
    y = bsc_channel(x,e);  %ͨ��BSC�ŵ�
    
    prob00=sum((x==0)&(y==0))/nBits;
    prob01=sum((x==0)&(y==1))/nBits;
    prob10=sum((x==1)&(y==0))/nBits;
    prob11=sum((x==1)&(y==1))/nBits;
    
    prob00=max(prob00,realmin); %�������NaN�����
    prob01=max(prob01,realmin);
    prob10=max(prob10,realmin);
    prob11=max(prob11,realmin);
    
    HYX=(-sum(prob00.*log2(prob00)))+(-sum(prob01.*log2(prob01)))+...
        (-sum(prob10.*log2(prob10)))+(-sum(prob11.*log2(prob11)));
    
    px0 = sum(x==0)/nBits;    % ����x=0�ı���
    px1 = sum(x==1)/nBits;    % ����x=1�ı���
    HX = -px0*log2(px0) - px1*log2(px1); %x����Ϣ��
    
    py0 =sum(y==0)/nBits;      % ����y=0�ı���
    py1 =sum(y==1)/nBits;      % ����y=1�ı���
    HY = -py0*log2(py0) - py1*log2(py1);%y����Ϣ��

    C(j)=HX+HY-HYX;%����
    j=j+1;
end
plot(errorProbs,C); title('BSC�ŵ�����');
xlabel('�������e');
ylabel('���� (bits/channel use)');
