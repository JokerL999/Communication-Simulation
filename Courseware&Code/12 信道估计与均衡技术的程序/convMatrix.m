function [H]=convMatrix(h,p)
%由输入N维矢量h和矢量p构造卷积矩阵 (N+p-1)x p
 h=h(:).';
 col=[h zeros(1,p-1)]; 
 row=[h(1) zeros(1,p-1)];
 H=toeplitz(col,row);
end