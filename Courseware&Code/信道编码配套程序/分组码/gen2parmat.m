function [H] = gen2parmat(G)
% ���ܣ�����׼��ʽ�����ɾ���Gת����Ӧ����żУ�����H
% ���룺��׼��ʽ�����ɾ���G
% �������żУ�����H

[k,n] = size(G);% G �� k x n
if k>n, error('G Ϊ k x n���ұ��� k<n'); end
I = eye(k); % k x k �ĵ�λ��

% �ж� G����ʽ�� [P | Ik] ���� [Ik | P]���ٹ��� H
P = G(:,1:n-k); Ik=G(:,n-k+1:n); %�� G �ֽ�� [P | Ik]�������ж�
if isequal(Ik,I) %G �� [P | Ik] ��ʽ
    H = [eye(n-k) P.'];
else
    Ik=G(:,1:k); P = G(:,k+1:n); %%�� G �ֽ�� [Ik | P]�������ж�
    if isequal(Ik,I) %G �� [Ik | P] ��ʽ
        H = [P.' eye(n-k)];
    else
        error('���� G ���Ǳ�׼��ʽ');
    end
end