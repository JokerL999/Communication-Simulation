%演示给定生成矩阵，生成校验子解码表
clearvars; clc;
G = [0 1 1 1 1 0 0; 
     1 0 1 1 0 1 0;
     1 1 0 1 0 0 1];

 syndromeTable=getSyndromeTable(G);
 
