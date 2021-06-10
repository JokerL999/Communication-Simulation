function [syndromeTable] = getSyndromeTable(G)
% 功能：生成校验子解码表
% 输入：G 生成矩阵
% 输出：syndromeTable 校验子解码表

H = gen2parmat(G);% 由生成矩阵 G,计算得到校验矩阵

A = standardArray(G);% 构造标准矩阵
B = H.';

S_full = cell(size(A));% 对标准矩阵中的所有码字，计算校验子
for ii = 1:numel(A)        
   S_full{ii} = mod(A{ii}*B,2);        
end

S_dec=bi2de(cell2mat(S_full(:,1)),'left-msb');% 将校验子矢量变成十进制数
%校验子与标准矩阵中的第一列（错误模式）组成校验子解码表
syndromeTable = [num2cell(S_dec) A(:,1)];  
syndromeTable = sortrows(syndromeTable,1);%排序后的校验子
