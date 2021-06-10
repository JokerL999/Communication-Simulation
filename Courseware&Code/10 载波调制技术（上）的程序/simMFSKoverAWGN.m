%MFSK的SER性能
clearvars;clc;close all
rng default

%% 参数设置
nSym=1e6;                %符号数目
EbN0dB = 0:2:24;        % Eb/N0[dB] 的仿真范围
arrayofM=[2,4,8,16,32];  %MFSK的阶数
% arrayofM=[2,4];  %MFSK的阶数
COHERENCE = 'coherent';   % MFSK的解调方案：'coherent'/'noncoherent'

%% 仿真
SER_theory=zeros(length(arrayofM),length(EbN0dB));
SER_sim=zeros(length(arrayofM),length(EbN0dB));
for i = 1:length(arrayofM)
    M=arrayofM(i);
    k=log2(M); 
    EsN0dB = 10*log10(k)+EbN0dB; %计算Es/N0的dB值
    
    d=randi([1,M],1,nSym);%生成1~M的符号值
    s=mfsk_modulator(M,d,COHERENCE);
    for j=1:length(EsN0dB)        
        r  = add_awgn_noise(s,EsN0dB(j)); %通过AWGN信道
        dCap  = mfsk_detector(M,r,COHERENCE);
        SER_sim(i,j) = sum((d~=dCap))/nSym; %计算SER  
    end
    %计算SER  
    %相干检测性能公式为《Digital Communications》第五版 （4-4-10）
    %              或《Fundamentals of Communication Systems》第2版（9.1.15）
    %非相干检测性能公式为《Fundamentals of Communication Systems》第2版（9.5.40）
    gamma_s=10.^(EsN0dB/10);
    if strcmpi(COHERENCE,'coherent')
        for ii=1:length(gamma_s)
            fun=@(x)(1-(1-0.5*(erfc(x/sqrt(2)))).^(M-1)).*exp(-(x-sqrt(2*gamma_s(ii))).^2/2); 
            SER_theory(i,ii) = 1/sqrt(2*pi)*integral(fun,-inf,inf);
        end
    else
        for ii=1:length(gamma_s)
            summ=0;
            for jj=1:M-1
                n=M-1; 
                r=jj; 
                summ=summ+(-1).^(jj+1)./(jj+1).*prod((n-r+1:n)./(1:r)).*exp(-jj./(jj+1).*gamma_s(ii));
            end
            SER_theory(i,ii)=summ; 
        end
    end
end

%% 结果展示  
plotColor =['b','g','r','c','m','k']; % 曲线颜色
legendString = cell(1,length(arrayofM)*2);
 for i=1:length(arrayofM)    
     semilogy(EbN0dB,SER_sim(i,:),[plotColor(i) '*']); hold on;
     semilogy(EbN0dB,SER_theory(i,:),plotColor(i)); 
     legendString{2*i-1}=['仿真 ',num2str(arrayofM(i)),'-FSK'];
     legendString{2*i}=['理论 ',num2str(arrayofM(i)),'-FSK'];
 end 
legend(legendString,'Location','southwest');
xlabel('Eb/N0(dB)')
ylabel('SER');
if strcmpi(COHERENCE,'coherent')
    title('相干MPSK的SER性能');
else
    title('非相干MPSK的SER性能');
end
ylim([1e-6,1])
hold off