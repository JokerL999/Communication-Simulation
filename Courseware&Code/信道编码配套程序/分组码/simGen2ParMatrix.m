% 生成矩阵和奇偶校验矩阵转换的示例
close all; clearvars;

G = [1 1 0 1 0 0 0; 
    0 1 1 0 1 0 0;
    1 1 1 0 0 1 0;
    1 0 1 0 0 0 1];

H = gen2parmat(G)% 将 G to H 
G = gen2parmat(H)% 将 H to G 
mod(G*H.',2) %验真是否 GH?T=0