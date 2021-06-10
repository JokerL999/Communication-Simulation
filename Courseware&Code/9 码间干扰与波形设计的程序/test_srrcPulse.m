close all; clearvars;
rng default;

Tsym=1; %符号周期
L=10; %过采样因子（每个符号的样点数目）
Nsym = 20; %滤波器跨度（以符号为单位，持续时间,-Nsym/2~Nsym/2）
betas=[0 0.3 0.5 1];%滚降因子
Fs=L/Tsym;%采样率

for i=1:length(betas) 
    beta=betas(i);
    [srrcPulseAtTx(i,:),t]=srrcFunction(beta,L,Nsym); %SRRC发端滤波器
    srrcPulseAtRx(i,:) = srrcPulseAtTx(i,:);%SRRC收端滤波器，和发端一样
    %两个滤波器合并
    combinedResponse(i,:) = conv(srrcPulseAtTx(i,:),srrcPulseAtRx(i,:),'same');    
   
    [vals(i,:),F]=FreqDomainAnalysis(srrcPulseAtTx(i,:),Fs,'double');
end

lineColors=['b','r','g','k','c']; 
legendString=cell(1,length(betas) );
t=Tsym*t;
for i=1:length(betas)     
    beta=betas(i);
    figure(1)
    plot(t,combinedResponse(i,:)/max(combinedResponse(i,:)),lineColors(i));
    hold on; 
    
    figure(2)
    plot(F,abs(vals(i,:))/abs(vals(i,length(vals(i,:))/2+1)),lineColors(i)); 
    hold on;
    legendString{i}=strcat('\beta =',num2str(beta) );i=i+1;  
end

figure(1)
title('SRRC滤波器的合并响应'); legend(legendString);
figure(2)
title('SRRC滤波器（发端或收端）频域响应');legend(legendString);