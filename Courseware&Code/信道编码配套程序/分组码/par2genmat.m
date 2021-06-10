function [G] = par2genmat(H)
% ���ܣ�����׼��ʽ����żУ�����Hת����Ӧ�����ɾ���G
% ���룺��׼��ʽ����żУ�����H
% ��������ɾ���G
      
[r,n] = size(H); %r=n-k ��У��λ��, H ������ (n-k) x n
k = n-r;
if r>n, error('���� H matrix ������ (n-k)xn �� (n-k)<n'); end
I = eye(n-k); % (n-k) x (n-k)�ĵ�λ��

% �ж� H ����ʽ�� [P' | I(n-k)] ���� [I(n-k) | P']���ٹ��� G
Pd = H(:,1:k); Ink=H(:,k+1:n); %�� H �ֽ�� [P' | I(n-k)]�������ж� 
if isequal(Ink,I) % H �� [P' | I(n-k)]
    G = [eye(k) Pd.'];
else
    Ik=H(:,1:n-k); Pd = H(:,n-k+1:n); % �� H �ֽ�� [I(n-k) | P']
    if isequal(Ik,I) %H �� [I(n-k) | P']
        G = [Pd.' eye(k)];
    else
        error('���� H ���Ǳ�׼��ʽ');
    end
end; 
