function [ref]= constructQAM(M)
% 输入
%   M   MQAM的阶数
%   ref Gray编码的MQAM星座点

a=GrayCodeGen(M);     %生成一维Gray编码的顺序
N=sqrt(M);            % K-Map的维度 - N x N matrix
a=reshape(a,N,N).';   % 将一位Gray编码改成N x N 矩阵
evenRows=2:2:size(a,1); % 找出偶数行
a(evenRows,:)=fliplr(a(evenRows,:));%  偶数行元素左右翻转
nGray=reshape(a.',1,M); % 再将N x N 矩阵转成一维矢量

% 构建MQAM的星座点
x=floor(nGray/N);
y=mod(nGray,N);
Ax=2*(x+1)-1-N; %PAM 幅度 2m-1-D - 实轴
Ay=2*(y+1)-1-N; %PAM 幅度 2m-1-D - 虚轴
ref=Ax+1i*Ay;   %MQAM 星座点 (I+jQ)
end

