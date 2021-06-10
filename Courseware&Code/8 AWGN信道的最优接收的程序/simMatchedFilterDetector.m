% 匹配滤波接收机的仿真实现
function [sBer,tBer]=simMatchedFilterDetector(SNRdB,Nsym)
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

sw(1,:)=ones(1,Nsam);          % 信号波形 ：正交信号
sw(2,:)=[ones(1,Nsam/2), -ones(1,Nsam/2)];

%计算波形能量和相关系数
E1=sum(sw(1,:).^2.*Tsam);
E2=sum(sw(2,:).^2.*Tsam);
Esym=(E1+E2)/2;

sBer=[];
tBer=[];
for SNR=10.^(SNRdB/10)
    N0=2*Esym/SNR;                    %单边功率谱密度
    halfN0=N0/2;                    %双边功率谱密度
    sigma_sT=sqrt(halfN0/Tsam);     %噪声功率，标准方差
    
    st= zeros(1,LB); 
    r= zeros(1,LB);
    y= zeros(2,LB);  %输出波形： 无噪声影响
    yr= zeros(2,LB); %输出波形： 有噪声影响
    
    s=zeros(1,Nsym);
    d=zeros(1,Nsym); %检测出的数据
    
    zi=zeros(2,length(sw(1,:))-1);
    zin=zeros(2,length(sw(1,:))-1);
    
    mf=1/Esym.*fliplr(sw);%匹配滤波器
    for n=1:Nsym
       s(n)=randi([0,1]); 
       i=s(n)+1; %0,对应1的波形；1，对应2的波形
       for m=1:Nsam 
         t=sw(i,m);
         tn=t+sigma_sT*randn;
         st=[st(2:LB) t];              % 发送信号波形
         r=[r(2:LB) tn]; % 被噪声影响的接收信号波形          
         
         if size(SNRdB,2)==1
             [yy(1,:),zi(1,:)]=filter(mf(1,:),[1],t,zi(1,:)); %无噪声影响下的匹配滤波器1输出
             [yy(2,:), zi(2,:)]=filter(mf(2,:),[1],t,zi(2,:)); %无噪声影响下的匹配滤波器2输出
             y=[y(:,2:LB) yy.*Tsam];
         end
         
         [yyn(1,:), zin(1,:)]=filter(mf(1,:),[1],tn,zin(1,:)); %有噪声影响下的匹配滤波器1输出
         [yyn(2,:), zin(2,:)]=filter(mf(2,:),[1],tn,zin(2,:)); %有噪声影响下的匹配滤波器2输出
         yr=[yr(:,2:LB) yyn.*Tsam]; 
       end
       % 检测器
       %d(n)=((yr(1,end)<yr(2,end)));
       d(n)=(yr(2,end)>yr(1,end));
    end
    sBer=[sBer sum(s~=d)/Nsym];
    tBer=[tBer qfn(sqrt(Esym/N0))];
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
    subplot(211), plot(t,y(1,:),'k:', t,yr(1,:),'b-')
    hold on, 
    stem(sp,yr(1,min(ceil(sp/Tsam),LB)),'r','Markersize',5) %sampled values
    set(gca,'fontsize',9), title('0的匹配滤波器输出')
    hold off

    subplot(212), plot(t,y(2,:),'k:', t,yr(2,:),'b-')
    hold on, 
    stem(sp,yr(2,min(ceil(sp/Tsam),LB)),'r','Markersize',5) %sampled values
    set(gca,'fontsize',9), title('1的匹配滤波器2输出')
    hold off
end

if size(SNRdB,2)>1 %若仿真多个SNRdB值，则绘制BER性能曲线
    semilogy(SNRdB,sBer,'-o',SNRdB,tBer,'-')
    legend('仿真结果','理论结果');
    xlabel('SNR[dB]')
    ylabel('BER')
    title('匹配滤波检测器性能')
end
