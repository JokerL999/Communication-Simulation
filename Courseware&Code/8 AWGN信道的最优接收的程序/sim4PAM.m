% ��ؽ��ջ��ķ���ʵ��
function sim4PAM(SNRdB,Nbit)
% SNR   �����dBֵ
% Nbit   ���������

if nargin == 0 %�����������Ĭ��չʾ
    clear, close all;
    SNRdB=6;
    Nbit=1e5;
elseif nargin == 1
    Nbit=1e5;   
end

rng default
M = 4;                                % ��������
k = log2(M);                          % ÿ���ŵĵ���
dataIn = randi([0 1],Nbit,1);         % �����������
dataInMatrix = reshape(dataIn,length(dataIn)/k,k);   
dataSymbolsIn = bi2de(dataInMatrix);                 % ��bitת�ɷ���
dataMod = double(pammod(dataSymbolsIn,M,0,'bin'));   % PAM���ƣ���λƫת0
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
    fprintf('����SER[%6.2e] ����SER[%6.2e] ����BER[%6.2e] ����BER[%6.2e]\n',sSer,tSer,sBer,tBer);
end

if size(SNRdB,2)>1 %��������SNRdBֵ�������BER��SER��������
    semilogy(SNRdB,sBer,'-o',SNRdB,tBer,'-')
    legend('������','���۽��');
    xlabel('SNR[dB]')
    ylabel('BER')
    title('4PAM BER����')
    
    figure    
    semilogy(SNRdB,sSer,'-o',SNRdB,tSer,'-')
    legend('������','���۽��');
    xlabel('SNR[dB]')
    ylabel('SER')
    title('4PAM SER����')
end
