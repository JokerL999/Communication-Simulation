function idealPoints= OptCoherentDetector(received,ref)
%������ɼ�⣬������MPAM,MPSK,MQAM��MFSK
%received - ���յ��ĸ��ź�
%ref - �ο�������
%idealPoints ����������

[m,~] = size(received);
[n,~] = size(ref);

if m==1 %��������Ϊһλʸ������MPAM,MPSK,MAQM,���źŹ���ɶ�ά�ϵ���������
    x=[real(received); imag(received)]';%�����źŵ�ʵ�����鲿
    y=[real(ref); imag(ref)]';          %�ο�������
else %���������źţ���MFSK����������һ����ά�ź�
    x=received;
    y=ref;
end


X = sum(x.*x,2);
Y = sum(y.*y,2)';
d = X(:,ones(1,n)) + Y(ones(1,m),:) - 2*x*y';%ŷ�Ͼ��ƽ��.
[~,idealPoints]=min(d,[],2); %Ѱ����Сŷʽ��ķ���
idealPoints=idealPoints.';
end

