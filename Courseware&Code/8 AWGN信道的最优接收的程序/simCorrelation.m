clear all; close all;
% ��ʼ��
K=20;       % ������Ŀ
A=1;        % �źŷ���
t=0:K;

% �����źŲ���
s_0=A*ones(1,K);
s_1=[A*ones(1,K/2) -A*ones(1,K/2)];

% ��ʼ���������
r_0=zeros(1,K);
r_1=zeros(1,K);

sigma=[0,0.1,1];%��������

for i=1:3
    noise=random('Normal',0,sigma(i),1,K);
    s=s_0;
    r=s+noise;  % �����ź�
    for n=1:K
        r_0(n)=sum(r(1:n).*s_0(1:n));
        r_1(n)=sum(r(1:n).*s_1(1:n));
    end
    
    subplot(3,2,(i-1)*2+1)
    plot(t,[0 r_0],'-',t,[0 r_1],'--')
    set(gca,'XTickLabel',{'0','5Tb','10Tb','15Tb','20Tb'})
    axis([0 20 -5 30])
    ss=strcat('(a) sigma^2=', num2str(sigma(i)), ' & ���� S_{0}');
    xlabel(ss,'fontsize',10)
    
    s=s_1;
    r=s+noise;  % �����ź�
    for n=1:K
        r_0(n)=sum(r(1:n).*s_0(1:n));
        r_1(n)=sum(r(1:n).*s_1(1:n));
    end

    subplot(3,2,(i-1)*2+2)
    plot(t,[0 r_0],'-',t,[0 r_1],'--')
    set(gca,'XTickLabel',{'0','5Tb','10Tb','15Tb','20Tb'})
    axis([0 20 -5 30])
    ss=strcat('(b) sigma^2=', num2str(sigma(i)), ' &  ���� S_{1}');
    xlabel(ss,'fontsize',10)
end

