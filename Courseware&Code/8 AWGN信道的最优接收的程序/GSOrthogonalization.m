function b=GSOrthogonalization(a)
%格拉姆-施密特正交化化
% 输入参数 a 列矢量构成的输入矩阵
% 输出参数 b 列矢量构成标准正交矢量
[m,n] = size(a);
if(m<n)
    error('行小于列，无法计算，请转置后重新输入');
    return
end
b=zeros(m,n);
%正交化
b(:,1)=a(:,1);
for i=2:n
    for j=1:i-1
        b(:,i)=a(:,i)-dot(a(:,i),b(:,j))/dot(b(:,j),b(:,j))*b(:,j);
    end
end
%矢量归一化
for k=1:n
    b(:,k)=b(:,k)/norm(b(:,k));
end