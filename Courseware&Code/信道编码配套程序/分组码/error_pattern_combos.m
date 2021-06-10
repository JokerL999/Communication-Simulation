function [E,nRows,nCols] = error_pattern_combos(d,n)
% 功能：对长度为n，错误为d的码字，生成所有可能的错误模式（错误位置组合）
% 输入：n 码字长度 d 错误数
% 输出：E 错误模式 nRows 行数 nCols 列数

C = nchoosek(1:n,d);%从1,2,...,n中任取d个数的所有组合
m = size(C,1); 
E = zeros(m,n);%form an all zero matrix of error patterns
for i=1:m
    for j=1:d
        E(i,C(i,j))=1;
    end
end
[nRows,nCols]= size(E);%num of rows and columns E matrix
end