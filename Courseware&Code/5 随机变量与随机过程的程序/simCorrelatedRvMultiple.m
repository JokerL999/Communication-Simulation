% ʹ��Cholesky�ֽ����ɶ���������ʾ��
clearvars; close all; clc;
rng default

C=[  1  0.5 0.3; 
    0.5  1  0.2;
    0.3 0.2  1 ;]; %��ؾ���
U=chol(C);         %Cholesky�ֽ�

N=1e5;        %���г���
R=randn(N,3); %����3��������������
Rc=R*U;       %����3������������X,Y,Z

%��֤
%�������ɵ��������֮�����ؾ���
coeffMatrixXX=corrcoef(Rc(:,1),Rc(:,1));
coeffMatrixXY=corrcoef(Rc(:,1),Rc(:,2));
coeffMatrixXZ=corrcoef(Rc(:,1),Rc(:,3));

%����ؾ�������ȡ�����ϵ��
coeffXX=coeffMatrixXX(1,2); %����X������X�����ϵ��
coeffXY=coeffMatrixXY(1,2); %����X������Y�����ϵ��
coeffXZ=coeffMatrixXZ(1,2); %����X������Z�����ϵ��

%��ͼ
subplot(1,3,1);plot(Rc(:,1),Rc(:,1),'b.');
title(['X and X, \rho=' num2str(coeffXX)]);xlabel('X');ylabel('X');
subplot(1,3,2);plot(Rc(:,1),Rc(:,2),'r.');
title(['X and Y, \rho=' num2str(coeffXY)]);xlabel('X');ylabel('Y');
subplot(1,3,3);plot(Rc(:,1),Rc(:,3),'k.');
title(['X and Z,\rho=' num2str(coeffXZ)]);xlabel('X');ylabel('Z');