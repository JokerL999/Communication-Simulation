%MFSK��SER����
clearvars;clc;close all
rng default

%% ��������
nSym=1e6;                %������Ŀ
EbN0dB = 0:2:24;        % Eb/N0[dB] �ķ��淶Χ
arrayofM=[2,4,8,16,32];  %MFSK�Ľ���
% arrayofM=[2,4];  %MFSK�Ľ���
COHERENCE = 'coherent';   % MFSK�Ľ��������'coherent'/'noncoherent'

%% ����
SER_theory=zeros(length(arrayofM),length(EbN0dB));
SER_sim=zeros(length(arrayofM),length(EbN0dB));
for i = 1:length(arrayofM)
    M=arrayofM(i);
    k=log2(M); 
    EsN0dB = 10*log10(k)+EbN0dB; %����Es/N0��dBֵ
    
    d=randi([1,M],1,nSym);%����1~M�ķ���ֵ
    s=mfsk_modulator(M,d,COHERENCE);
    for j=1:length(EsN0dB)        
        r  = add_awgn_noise(s,EsN0dB(j)); %ͨ��AWGN�ŵ�
        dCap  = mfsk_detector(M,r,COHERENCE);
        SER_sim(i,j) = sum((d~=dCap))/nSym; %����SER  
    end
    %����SER  
    %��ɼ�����ܹ�ʽΪ��Digital Communications������� ��4-4-10��
    %              ��Fundamentals of Communication Systems����2�棨9.1.15��
    %����ɼ�����ܹ�ʽΪ��Fundamentals of Communication Systems����2�棨9.5.40��
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

%% ���չʾ  
plotColor =['b','g','r','c','m','k']; % ������ɫ
legendString = cell(1,length(arrayofM)*2);
 for i=1:length(arrayofM)    
     semilogy(EbN0dB,SER_sim(i,:),[plotColor(i) '*']); hold on;
     semilogy(EbN0dB,SER_theory(i,:),plotColor(i)); 
     legendString{2*i-1}=['���� ',num2str(arrayofM(i)),'-FSK'];
     legendString{2*i}=['���� ',num2str(arrayofM(i)),'-FSK'];
 end 
legend(legendString,'Location','southwest');
xlabel('Eb/N0(dB)')
ylabel('SER');
if strcmpi(COHERENCE,'coherent')
    title('���MPSK��SER����');
else
    title('�����MPSK��SER����');
end
ylim([1e-6,1])
hold off