function [stdArray] = standardArray(G)
% 功能：给定生成矩阵，生成标准阵列
% 输入：G 生成矩阵
% 输出：stdArray 标准阵列
[k,n] = size(G); 

M = dec2bin(0:2^k-1)-'0'; %k个信息位的所有可能信息序列
C = mod(M*G,2);% 所有可能的码字，C也就是码本

S = C;%S保存标准阵列中所有的码字，用于后面的循环搜索
stdArray = mat2cell(C,ones(1,2^k),n).'; 

for d=1:n %生成所有可能的错误
    [E,nRows,~] = error_pattern_combos(d,n);%生成所有d个错误的模式
    for j=1:nRows %针对每个错误模式，生成错误码字
        if sum(ismember(E(j,:),S,'rows'))==0 %判断错误模式在S中是否存在
            %若这个错误模式在S中不存在
            coset = mod(C + repmat(E(j,:),2^k,1),2); % 对码本中2^k个码字，逐一按照第j个错误模式，生成错误码字
            S = vertcat(S,coset);%更新标准阵列中所有的码字
            stdArray = vertcat(stdArray,mat2cell(coset,ones(1,2^k),n).');%转换成元胞存储
        end
    end
end