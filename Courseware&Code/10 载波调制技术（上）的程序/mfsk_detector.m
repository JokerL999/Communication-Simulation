function [Out]= mfsk_detector(M,r,COHERENCE)
% �������
% M ���ƽ���
% r ���ܵ��źŵ㣬Ϊ��ʸ��
% COHERENCE  MFSK�Ľ������'coherent'/'noncoherent'
% �������
% Out  ������
if strcmpi(COHERENCE,'coherent')
  phi= zeros(1,M); %����ɼ�⣬phaseΪ0
  ref = complex(diag(exp(1i*phi)));%���ɲο�����
  Out= OptCoherentDetector(real(r),ref);%��ɼ��
else %�����MFSK
  [~,Out]= max(abs(r),[],2);%��ɷ��ȼ��
  Out = Out.';
end
end