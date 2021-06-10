close all; clearvars;
rng default;

Tsym=1; %符号周期
L=10; %过采样因子（每个符号的样点数目）
Nsym = 20; %滤波器跨度（以符号为单位，持续时间,-Nsym/2~Nsym/2）
alphas=[0 0.3 0.5 1];%滚降因子
Fs=L/Tsym;%采样率

for i=1:length(alphas) 
    alpha=alphas(i);
    [rcPulse(i,:),t]=raisedCosineFunction(alpha,L,Nsym); % 生成波形   
    [vals(i,:),f]=FreqDomainAnalysis(rcPulse(i,:),Fs,'double'); % 频域分析  
end

lineColors=['b','r','g','k','c']; 
legendString=cell(1,4);
t=Tsym*t; 
for i=1:length(alphas) 
    alpha=alphas(i);
    figure(1) 
    plot(t,rcPulse(i,:),lineColors(i));hold on;     
    figure(2)
    plot(f,abs(vals(i,:))/abs(vals(i,length(vals(i,:))/2+1)),lineColors(i)); 
    hold on;
    legendString{i}=strcat('\alpha =',num2str(alpha) );
end
figure(1);title('升余弦脉冲');legend(legendString);
figure(2);title('频域响应');legend(legendString);

