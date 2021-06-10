function [G] = par2genmat(H)
% 功能：将标准形式的奇偶校验矩阵H转成相应的生成矩阵G
% 输入：标准形式的奇偶校验矩阵H
% 输出：生成矩阵G
      
[r,n] = size(H); %r=n-k 是校验位数, H 矩阵是 (n-k) x n
k = n-r;
if r>n, error('矩阵 H matrix 必须是 (n-k)xn 且 (n-k)<n'); end
I = eye(n-k); % (n-k) x (n-k)的单位阵

% 判断 H 的形式是 [P' | I(n-k)] 还是 [I(n-k) | P']，再构成 G
Pd = H(:,1:k); Ink=H(:,k+1:n); %将 H 分解成 [P' | I(n-k)]，再做判断 
if isequal(Ink,I) % H 是 [P' | I(n-k)]
    G = [eye(k) Pd.'];
else
    Ik=H(:,1:n-k); Pd = H(:,n-k+1:n); % 将 H 分解成 [I(n-k) | P']
    if isequal(Ik,I) %H 是 [I(n-k) | P']
        G = [Pd.' eye(k)];
    else
        error('矩阵 H 不是标准形式');
    end
end; 
