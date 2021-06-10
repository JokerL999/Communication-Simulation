% �����Ȼ���ʾ��

clear all; close all
N=1e3;                         %���������Ŀ
s=randi([0,1],1,N);            %���͵ı�����
x=zeros(2,N);                  %�����ź�ʸ��
d=zeros(1,N);                  %�����ı�����   
N0=0.5;                        %�������߹������ܶ�

V(:,1)=[-1/sqrt(2);-1/sqrt(2)];  %����0��Ӧ���ź�ʸ��1
V(:,2)=[1/sqrt(2);1/sqrt(2)];    %����1��Ӧ���ź�ʸ��2

% ����ӳ�䵽�ź�ʸ�������ƣ�
for i=1:N
    if s(i)==0
       x(:,i)=V(:,1);
    elseif s(i)==1
       x(:,i)=V(:,2);
    end
end

n = sqrt(N0/2)*randn(size(x));         %��������
y=x+n;                                 %�ź�ʸ��ͨ��AWGN�ŵ�

figure
hold on
for i=1:length(x)
    if s(i)==0
        plot(y(1,i),y(2,i),'bo');
    else
        plot(y(1,i),y(2,i),'m*');
    end
    
    % �����Ȼ��⣬ŷ�Ͼ���С�ģ���Ϊ�о��������
    if sum((y(:,i)-V(:,1)).^2).^0.5<sum((y(:,i)-V(:,2)).^2).^0.5
        d(i)=0;
    else
        d(i)=1;
    end
end
plot(V(1,1),V(2,1),'k+',V(1,2),V(2,2),'k+','MarkerSize',15)
title('�����ź�')
axis([-3,3,-3,3])
hold off

% ��������������������
[No_of_error_bits,BER]=biterr(s,d)
e=(s~=d); % �ҳ�����ı������
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
title('�����Ȼ������ȷ�ʹ�����ź�')
axis([-3,3,-3,3])
hold off
