% 相关接收机的仿真实现
function sim4PAM(SNRdB,Nbit)
% SNR   信噪比dB值
% Nbit   仿真比特数

if nargin == 0 %无输入参数，默认展示
    clear, close all;
    SNRdB=6;
    Nbit=1e5;
elseif nargin == 1
    Nbit=1e5;   
end

rng default
M = 4;                                % 星座点数
k = log2(M);                          % 每符号的点数
dataIn = randi([0 1],Nbit,1);         % 生成随机比特
dataInMatrix = reshape(dataIn,length(dataIn)/k,k);   
dataSymbolsIn = bi2de(dataInMatrix);                 % 把bit转成符号
dataMod = double(pammod(dataSymbolsIn,M,0,'bin'));   % PAM调制，相位偏转0
Nsym=Nbit/k;

sBer=[];
tBer=[];
sSer=[];
tSer=[];
for SNR=10.^(SNRdB/10)
    y = awgn(dataMod,10*log10(SNR),'measured');
    dataSymbolsOut = pamdemod(y,M,0,'bin');
    dataOutMatrix = de2bi(dataSymbolsOut,k);
    dataOut = dataOutMatrix(:);                   % Return data in column vector

    sBer=[sBer sum(dataIn~=dataOut)/Nbit];
    tBer=[tBer 3/4*qfn(sqrt(SNR/5))];
    sSer=[sSer sum(dataSymbolsOut~=dataSymbolsIn)/Nsym];
    tSer=[tSer 1.5*qfn(sqrt(SNR/5))];
    fprintf('仿真SER[%6.2e] 理论SER[%6.2e] 仿真BER[%6.2e] 理论BER[%6.2e]\n',sSer,tSer,sBer,tBer);
end

if size(SNRdB,2)>1 %若仿真多个SNRdB值，则绘制BER和SER性能曲线
    semilogy(SNRdB,sBer,'-o',SNRdB,tBer,'-')
    legend('仿真结果','理论结果');
    xlabel('SNR[dB]')
    ylabel('BER')
    title('4PAM BER性能')
    
    figure    
    semilogy(SNRdB,sSer,'-o',SNRdB,tSer,'-')
    legend('仿真结果','理论结果');
    xlabel('SNR[dB]')
    ylabel('SER')
    title('4PAM SER性能')
end
