clearvars; clc;

 G = [1 0 0 0 1 0 1;     % 生成矩阵 k x n
      0 1 0 0 1 1 1;
      0 0 1 0 1 1 0;
      0 0 0 1 0 1 1];
 
[k,n] = size(G); 
H = gen2parmat(G); % 生成校验
syndromeTable = getSyndromeTable(G);%生成校验子解码表

% 验证校验子解码
% 发射机
x = rand(1,k) > 0.5 % 随机生成输入信息序列
c = mod(x*G,2)      % 生成线性分组码字

% 信道
d = 1; % 产生d个bit的错误
[E,nRows,nCols] = error_pattern_combos(d,n); % 产生d个比特错误的所有模式
index = randi([1,nRows]); %随机选择一个错误模式
e = E(index,:) 
r = mod(c + e,2) % 包含错误的接收码字

% 接收机
s = mod(r*H.',2) % 计算校验子
s_dec = bi2de(s,'left-msb'); % 校验子转成十进制

errorEst=syndromeTable(s_dec+1,2);% 从校验子解码表中找到错误模式，也即错误位置
errorEst = cell2mat(errorEst)
recoveredCW = mod(r - errorEst,2) % 恢复码字

if (recoveredCW==c)
    disp('解码成功');
else
    disp('解码失败');
end