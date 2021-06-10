%演示给定生成矩阵，生成标准阵列
clearvars; clc;
G = [0 1 1 1 1 0 0; 
     1 0 1 1 0 1 0;
     1 1 0 1 0 0 1];
[stdArray] = standardArray(G);

