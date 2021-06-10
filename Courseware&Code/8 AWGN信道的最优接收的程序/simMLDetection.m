% 最大似然检测示例

clear all; close all
N=1e3;                         %仿真比特数目
s=randi([0,1],1,N);            %发送的比特流
x=zeros(2,N);                  %发送信号矢量
d=zeros(1,N);                  %检测出的比特流   
N0=0.5;                        %噪声单边功率谱密度

V(:,1)=[-1/sqrt(2);-1/sqrt(2)];  %比特0对应的信号矢量1
V(:,2)=[1/sqrt(2);1/sqrt(2)];    %比特1对应的信号矢量2

% 比特映射到信号矢量（调制）
for i=1:N
    if s(i)==0
       x(:,i)=V(:,1);
    elseif s(i)==1
       x(:,i)=V(:,2);
    end
end

n = sqrt(N0/2)*randn(size(x));         %生成噪声
y=x+n;                                 %信号矢量通过AWGN信道

figure
hold on
for i=1:length(x)
    if s(i)==0
        plot(y(1,i),y(2,i),'bo');
    else
        plot(y(1,i),y(2,i),'m*');
    end
    
    % 最大似然检测，欧氏距离小的，作为判决比特输出
    if sum((y(:,i)-V(:,1)).^2).^0.5<sum((y(:,i)-V(:,2)).^2).^0.5
        d(i)=0;
    else
        d(i)=1;
    end
end
plot(V(1,1),V(2,1),'k+',V(1,2),V(2,2),'k+','MarkerSize',15)
title('接收信号')
axis([-3,3,-3,3])
hold off

% 计算错误比特数和误码率
[No_of_error_bits,BER]=biterr(s,d)
e=(s~=d); % 找出错误的比特序号
figure
hold on
for i=1:length(x)    
    if s(i)==0
        if(e(i)==1)
            plot(y(1,i),y(2,i),'ro');
        else
            plot(y(1,i),y(2,i),'go');
        end
    else
        if(e(i)==1)
            plot(y(1,i),y(2,i),'r*');
        else
            plot(y(1,i),y(2,i),'g*');
        end
    end
end
plot(V(1,1),V(2,1),'k+',V(1,2),V(2,2),'k+','MarkerSize',15)
title('最大似然检测后正确和错误的信号')
axis([-3,3,-3,3])
hold off
