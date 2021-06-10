clear all;
% ��ʼ��
K=20;       % ������Ŀ
A=1;        % �źŷ���
l=0:K;

% �����źŲ���
s_0=A*ones(1,K);
s_1=[A*ones(1,K/2) -A*ones(1,K/2)];
% ��ʼ������ź�
y_0=zeros(1,K);
y_1=zeros(1,K);

sigma=[0,0.1,1];%��������

for i=1:3
    noise=random('Normal',0,sigma(i),1,K);
    s=s_0;
    y=s+noise;  % �����ź�
    
    y_0=conv(y,fliplr(s_0));
    y_1=conv(y,fliplr(s_1));

    subplot(3,2,(i-1)*2+1)
    plot(l,[0 y_0(1:K)],'-',l,[0 y_1(1:K)],'--')
    set(gca,'XTickLabel',{'0','5Tb','10Tb','15Tb','20Tb'})
    axis([0 20 -30 30])
    ss=strcat('(a) sigma^2=', num2str(sigma(i)), ' & ���� S_{0}');
    xlabel(ss,'fontsize',10)
    % s = s_1:
    s=s_1;
    y=s+noise;  % �����ź�
    y_0=conv(y,fliplr(s_0));
    y_1=conv(y,fliplr(s_1));

    subplot(3,2,(i-1)*2+2)
    plot(l,[0 y_0(1:K)],'-',l,[0 y_1(1:K)],'--')
    set(gca,'XTickLabel',{'0','5Tb','10Tb','15Tb','20Tb'})
    axis([0 20 -30 30])
    ss=strcat('(b) sigma^2=', num2str(sigma(i)), ' & ���� S_{1}');
    xlabel(ss,'fontsize',10)
end

