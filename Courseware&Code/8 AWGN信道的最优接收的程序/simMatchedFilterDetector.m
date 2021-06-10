% ƥ���˲����ջ��ķ���ʵ��
function [sBer,tBer]=simMatchedFilterDetector(SNRdB,Nsym)
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

sw(1,:)=ones(1,Nsam);          % �źŲ��� �������ź�
sw(2,:)=[ones(1,Nsam/2), -ones(1,Nsam/2)];

%���㲨�����������ϵ��
E1=sum(sw(1,:).^2.*Tsam);
E2=sum(sw(2,:).^2.*Tsam);
Esym=(E1+E2)/2;

sBer=[];
tBer=[];
for SNR=10.^(SNRdB/10)
    N0=2*Esym/SNR;                    %���߹������ܶ�
    halfN0=N0/2;                    %˫�߹������ܶ�
    sigma_sT=sqrt(halfN0/Tsam);     %�������ʣ���׼����
    
    st= zeros(1,LB); 
    r= zeros(1,LB);
    y= zeros(2,LB);  %������Σ� ������Ӱ��
    yr= zeros(2,LB); %������Σ� ������Ӱ��
    
    s=zeros(1,Nsym);
    d=zeros(1,Nsym); %����������
    
    zi=zeros(2,length(sw(1,:))-1);
    zin=zeros(2,length(sw(1,:))-1);
    
    mf=1/Esym.*fliplr(sw);%ƥ���˲���
    for n=1:Nsym
       s(n)=randi([0,1]); 
       i=s(n)+1; %0,��Ӧ1�Ĳ��Σ�1����Ӧ2�Ĳ���
       for m=1:Nsam 
         t=sw(i,m);
         tn=t+sigma_sT*randn;
         st=[st(2:LB) t];              % �����źŲ���
         r=[r(2:LB) tn]; % ������Ӱ��Ľ����źŲ���          
         
         if size(SNRdB,2)==1
             [yy(1,:),zi(1,:)]=filter(mf(1,:),[1],t,zi(1,:)); %������Ӱ���µ�ƥ���˲���1���
             [yy(2,:), zi(2,:)]=filter(mf(2,:),[1],t,zi(2,:)); %������Ӱ���µ�ƥ���˲���2���
             y=[y(:,2:LB) yy.*Tsam];
         end
         
         [yyn(1,:), zin(1,:)]=filter(mf(1,:),[1],tn,zin(1,:)); %������Ӱ���µ�ƥ���˲���1���
         [yyn(2,:), zin(2,:)]=filter(mf(2,:),[1],tn,zin(2,:)); %������Ӱ���µ�ƥ���˲���2���
         yr=[yr(:,2:LB) yyn.*Tsam]; 
       end
       % �����
       %d(n)=((yr(1,end)<yr(2,end)));
       d(n)=(yr(2,end)>yr(1,end));
    end
    sBer=[sBer sum(s~=d)/Nsym];
    tBer=[tBer qfn(sqrt(Esym/N0))];
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
    subplot(211), plot(t,y(1,:),'k:', t,yr(1,:),'b-')
    hold on, 
    stem(sp,yr(1,min(ceil(sp/Tsam),LB)),'r','Markersize',5) %sampled values
    set(gca,'fontsize',9), title('0��ƥ���˲������')
    hold off

    subplot(212), plot(t,y(2,:),'k:', t,yr(2,:),'b-')
    hold on, 
    stem(sp,yr(2,min(ceil(sp/Tsam),LB)),'r','Markersize',5) %sampled values
    set(gca,'fontsize',9), title('1��ƥ���˲���2���')
    hold off
end

if size(SNRdB,2)>1 %��������SNRdBֵ�������BER��������
    semilogy(SNRdB,sBer,'-o',SNRdB,tBer,'-')
    legend('������','���۽��');
    xlabel('SNR[dB]')
    ylabel('BER')
    title('ƥ���˲����������')
end
