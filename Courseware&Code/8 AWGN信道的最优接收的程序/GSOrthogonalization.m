function b=GSOrthogonalization(a)
%����ķ-ʩ������������
% ������� a ��ʸ�����ɵ��������
% ������� b ��ʸ�����ɱ�׼����ʸ��
[m,n] = size(a);
if(m<n)
    error('��С���У��޷����㣬��ת�ú���������');
    return
end
b=zeros(m,n);
%������
b(:,1)=a(:,1);
for i=2:n
    for j=1:i-1
        b(:,i)=a(:,i)-dot(a(:,i),b(:,j))/dot(b(:,j),b(:,j))*b(:,j);
    end
end
%ʸ����һ��
for k=1:n
    b(:,k)=b(:,k)/norm(b(:,k));
end