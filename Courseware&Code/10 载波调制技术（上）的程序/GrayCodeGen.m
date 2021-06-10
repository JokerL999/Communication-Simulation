function gray_code=GrayCodeGen(M)
% 生成格雷编码
% 输入M：阶数，也即生成0：M-1的格雷码

N=log2(M);
SubGray=[0;1];
for n=2:N
    top_gray=[zeros(1,2^(n-1))' SubGray];
    ReflectedSubGray=flipud(SubGray);
    bottom_gray=[ones(1,2^(n-1))' ReflectedSubGray];
    SubGray=[top_gray;bottom_gray];
end
gray_code=bi2de(fliplr(SubGray))';
end