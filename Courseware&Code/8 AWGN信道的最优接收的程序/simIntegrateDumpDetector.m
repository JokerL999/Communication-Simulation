% integrate-and-dump detector�ķ���ʵ��
function [sBer,tBer]=simIntegrateDumpDetector(SNRdB,Nsym)
% SNR    �����dBֵ
% Nsym   ���������
% sBer   ����ͳ��BER
% tBer   ���ۼ���BER

if nargin == 0 %�����������Ĭ��չʾ
    clear, close all;
    SNRdB=6;
    Nsym=1e5;
elseif nargin == 1
    Nsym=1e5;   
end

rng default

Tsym=1;                         %��������
Nsam=20;                        %��������
Tsam=Tsym/Nsam;                 %��������

L=6;                           %����L�����Ų��Σ�����չʾ
LB=L*Nsam;                     %����Ĳ���ʸ������
Es=1;                          %һ�����ŵ�����
A=sqrt(Es/Tsym);               % ���εķ���
su=[-1;1]*ones(1,Nsam);        % ��λ���Ȳ���
sw=A*su;                       % �����ȵķ��Ͳ���
sBer=[];
tBer=[];
for SNR=10.^(SNRdB/10)
    N0=2*Es/SNR;                    %���߹������ܶ�
    halfN0=N0/2;                    %˫�߹������ܶ�
    sigma_sT=sqrt(halfN0/Tsam);     %�������ʣ���׼����
    
    st= zeros(1,LB); 
    r= zeros(1,LB);
    y_ID= zeros(1,LB);
    yr_ID= zeros(1,LB);
    
    s=zeros(1,Nsym);
    D_ID=zeros(1,Nsym);

    for n=1:Nsym
       s(n)=randi([0,1]); 
       i=s(n)+1; %0,��Ӧ1�Ĳ��Σ�1����Ӧ2�Ĳ���
       for m=1:Nsam 
         st=[st(2:LB) sw(i,m)];              % �����źŲ���
         r=[r(2:LB) sw(i,m)+sigma_sT*randn]; % ������Ӱ��Ľ����źŲ���     

         y_ID=[y_ID(:,2:LB) sum(st(end-m+1:end))*Tsam]; % ������Ӱ��Ļ��������
         yr_ID=[yr_ID(:,2:LB) sum(r(end-m+1:end))*Tsam]; % ������Ӱ��Ļ��������
       end
       % �����
       D_ID(n)=(yr_ID(1,end)>0);
    end
    sBer=[sBer sum(s~=D_ID)/Nsym];
    tBer=[tBer qfn(sqrt(2*A^2*Tsym/N0))];
end

if size(SNRdB,2)==1 %������һ��SNRdB,������ܼ��շ�����
    fprintf('����BER[%6.2e] ����BER[%6.2e]\n',sBer,tBer);
    t= [1:LB]*Tsam; % ����չʾ��ʱ��ʸ��
    sp=[1:L]*Tsym;  % �������ʱ��ʸ��

    figure
    plot(t,st,'p:', t,r,'b-')
    legend('������','������')
    for n=1:6, text(n-0.5,-10,sprintf('%1d',s(end-6+n))); end
    axis([0 6 -12 12]), set(gca,'fontsize',9), title('�����ź� r(t)')

    figure
    plot(t,y_ID,'p:', t,yr_ID,'b-')
    hold on, 
    stem(sp,yr_ID(min(ceil(sp/Tsam),LB)),'r','Markersize',5) %������
    set(gca,'fontsize',9), title('��������')
end

if size(SNRdB,2)>1 %��������SNRdBֵ�������BER��������
    semilogy(SNRdB,sBer,'-o',SNRdB,tBer,'-')
    legend('������','���۽��');
    xlabel('SNR[dB]')
    ylabel('BER')
    title('���ּ��������')
end
