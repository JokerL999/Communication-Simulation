% integrate-and-dump detector的仿真实现
function [sBer,tBer]=simIntegrateDumpDetector(SNRdB,Nsym)
% SNR    信噪比dB值
% Nsym   仿真符号数
% sBer   仿真统计BER
% tBer   理论计算BER

if nargin == 0 %无输入参数，默认展示
    clear, close all;
    SNRdB=6;
    Nsym=1e5;
elseif nargin == 1
    Nsym=1e5;   
end

rng default

Tsym=1;                         %符号周期
Nsam=20;                        %采样倍数
Tsam=Tsym/Nsam;                 %采样周期

L=6;                           %保存L个符号波形，用于展示
LB=L*Nsam;                     %保存的波形矢量长度
Es=1;                          %一个符号的能量
A=sqrt(Es/Tsym);               % 波形的幅度
su=[-1;1]*ones(1,Nsam);        % 单位幅度波形
sw=A*su;                       % 带幅度的发送波形
sBer=[];
tBer=[];
for SNR=10.^(SNRdB/10)
    N0=2*Es/SNR;                    %单边功率谱密度
    halfN0=N0/2;                    %双边功率谱密度
    sigma_sT=sqrt(halfN0/Tsam);     %噪声功率，标准方差
    
    st= zeros(1,LB); 
    r= zeros(1,LB);
    y_ID= zeros(1,LB);
    yr_ID= zeros(1,LB);
    
    s=zeros(1,Nsym);
    D_ID=zeros(1,Nsym);

    for n=1:Nsym
       s(n)=randi([0,1]); 
       i=s(n)+1; %0,对应1的波形；1，对应2的波形
       for m=1:Nsam 
         st=[st(2:LB) sw(i,m)];              % 发送信号波形
         r=[r(2:LB) sw(i,m)+sigma_sT*randn]; % 被噪声影响的接收信号波形     

         y_ID=[y_ID(:,2:LB) sum(st(end-m+1:end))*Tsam]; % 无噪声影响的积分器输出
         yr_ID=[yr_ID(:,2:LB) sum(r(end-m+1:end))*Tsam]; % 有噪声影响的积分器输出
       end
       % 检测器
       D_ID(n)=(yr_ID(1,end)>0);
    end
    sBer=[sBer sum(s~=D_ID)/Nsym];
    tBer=[tBer qfn(sqrt(2*A^2*Tsym/N0))];
end

if size(SNRdB,2)==1 %若仿真一个SNRdB,输出性能及收发波形
    fprintf('仿真BER[%6.2e] 理论BER[%6.2e]\n',sBer,tBer);
    t= [1:LB]*Tsam; % 用于展示的时间矢量
    sp=[1:L]*Tsym;  % 采样点的时间矢量

    figure
    plot(t,st,'p:', t,r,'b-')
    legend('无噪声','有噪声')
    for n=1:6, text(n-0.5,-10,sprintf('%1d',s(end-6+n))); end
    axis([0 6 -12 12]), set(gca,'fontsize',9), title('接收信号 r(t)')

    figure
    plot(t,y_ID,'p:', t,yr_ID,'b-')
    hold on, 
    stem(sp,yr_ID(min(ceil(sp/Tsam),LB)),'r','Markersize',5) %采样点
    set(gca,'fontsize',9), title('检测器输出')
end

if size(SNRdB,2)>1 %若仿真多个SNRdB值，则绘制BER性能曲线
    semilogy(SNRdB,sBer,'-o',SNRdB,tBer,'-')
    legend('仿真结果','理论结果');
    xlabel('SNR[dB]')
    ylabel('BER')
    title('积分检测器性能')
end
