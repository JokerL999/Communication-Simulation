% 仿真计算BEC容量
clearvars; close all; clc
nBits=10^5;           %发送的比特数
errorProbs = 0:0.1:1; %擦除概率
C = zeros(1,length(errorProbs));
j=1;
for e=errorProbs %for each error probability
    x = randi([0,1],1,nBits);
    y = bec_channel(x,e);  %通过BEC信道
    
    pye = sum(y==-1)/nBits ;%擦除的概率
    C(j) = 1-pye; %容量    
    j=j+1;
end
plot(errorProbs,C); title('二进制擦除信道容量');
xlabel('擦除概率 - e'); 
ylabel('容量 (bits/channel use)');