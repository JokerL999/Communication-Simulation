clear all;
close all; 
clc; 

t=0:0.1:20;
wav=sin(t);

figure;
plot(wav,'r'); 
hold on 

[sqnr,wav_riser]=UniPcm(wav,8);
sqnr

% 画出量化之后的声波
plot(wav_riser,'b')
title('均匀量化');
hold off 

function [sqnr,x_qtz]=UniPcm(x,n)
% x输入信号
% n量化电平数量

xmax=max(abs(x));
x_qtz=x/xmax;
delta=2/n;
q=delta*[0:n-1]-(n-1)/2*delta;

for i=1:n
    index=find((q(i)-delta/2<=x_qtz)&(x_qtz<=q(i)+delta/2));%找出所有不为零的位置
    x_qtz(index)=q(i)*ones(1,length(index));%相应位置上设置量化电平
end

x_qtz=x_qtz*xmax;
sqnr=20*log10(norm(x)./norm(x-x_qtz));
end
