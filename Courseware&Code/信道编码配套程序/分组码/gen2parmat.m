function [H] = gen2parmat(G)
% 功能：将标准形式的生成矩阵G转成相应的奇偶校验矩阵H
% 输入：标准形式的生成矩阵G
% 输出：奇偶校验矩阵H

[k,n] = size(G);% G 是 k x n
if k>n, error('G 为 k x n，且必须 k<n'); end
I = eye(k); % k x k 的单位阵

% 判断 G的形式是 [P | Ik] 还是 [Ik | P]，再构成 H
P = G(:,1:n-k); Ik=G(:,n-k+1:n); %将 G 分解成 [P | Ik]，再做判断
if isequal(Ik,I) %G 是 [P | Ik] 形式
    H = [eye(n-k) P.'];
else
    Ik=G(:,1:k); P = G(:,k+1:n); %%将 G 分解成 [Ik | P]，再做判断
    if isequal(Ik,I) %G 是 [Ik | P] 形式
        H = [P.' eye(n-k)];
    else
        error('矩阵 G 不是标准形式');
    end
end