%��ѡ�������������
clearvars;close all
rng('default') % ��ʼ�����ӣ�����������

n=1e5;%��������
f = @(x)x.*exp(-(x.^2)/2);
g = @(x)exp(-x);
grnd = @()exprnd(1); 
X = ARMethod(f,g,grnd,2.2,n,1);

t=0:0.1:10;
t_pdf=f(t);
Y = raylrnd(1,n,1);%MATLAB���õ������ֲ������������
subplot(211);histogram(X,'Normalization','pdf');
hold on; plot(t,t_pdf,'m-');hold off;title('��ѡ��')
xlim([0,5]);legend('����','����');
subplot(212);histogram(Y,'Normalization','pdf');
hold on; plot(t,t_pdf,'m-');hold off;title('MATLAB���ú���')
xlim([0,5]);legend('����','����');

function X = ARMethod(f,g,grnd,c,m,n)
%��ѡ��ʵ��
% f: f(x)��������; g: g(x)��������; grnd�������ܶȺ���Ϊg(x)�������������
% m��n�������ά��
    X = zeros(m,n); % Ԥ����洢�ռ�
    for i = 1:m*n
        accept = false;
        while accept == false
            u = rand(); v = grnd();
            if c*u <= f(v)/g(v)
               X(i) = v;
               accept = true;
            end
        end
    end
end
