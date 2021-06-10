function [H]=convMatrix(h,p)
%������Nάʸ��h��ʸ��p���������� (N+p-1)x p
 h=h(:).';
 col=[h zeros(1,p-1)]; 
 row=[h(1) zeros(1,p-1)];
 H=toeplitz(col,row);
end