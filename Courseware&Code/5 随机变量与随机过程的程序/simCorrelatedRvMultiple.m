% 使用Cholesky分解生成多个随机序列示例
clearvars; close all; clc;
rng default

C=[  1  0.5 0.3; 
    0.5  1  0.2;
    0.3 0.2  1 ;]; %相关矩阵
U=chol(C);         %Cholesky分解

N=1e5;        %序列长度
R=randn(N,3); %生成3条不相干随机序列
Rc=R*U;       %生成3条相关随机序列X,Y,Z

%验证
%计算生成的相关序列之间的相关矩阵
coeffMatrixXX=corrcoef(Rc(:,1),Rc(:,1));
coeffMatrixXY=corrcoef(Rc(:,1),Rc(:,2));
coeffMatrixXZ=corrcoef(Rc(:,1),Rc(:,3));

%从相关矩阵中提取出相关系数
coeffXX=coeffMatrixXX(1,2); %序列X与序列X的相关系数
coeffXY=coeffMatrixXY(1,2); %序列X与序列Y的相关系数
coeffXZ=coeffMatrixXZ(1,2); %序列X与序列Z的相关系数

%绘图
subplot(1,3,1);plot(Rc(:,1),Rc(:,1),'b.');
title(['X and X, \rho=' num2str(coeffXX)]);xlabel('X');ylabel('X');
subplot(1,3,2);plot(Rc(:,1),Rc(:,2),'r.');
title(['X and Y, \rho=' num2str(coeffXY)]);xlabel('X');ylabel('Y');
subplot(1,3,3);plot(Rc(:,1),Rc(:,3),'k.');
title(['X and Z,\rho=' num2str(coeffXZ)]);xlabel('X');ylabel('Z');