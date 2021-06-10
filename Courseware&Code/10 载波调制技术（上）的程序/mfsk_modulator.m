function [s,ref]= mfsk_modulator(M,d,COHERENCE)
% �������
% M ���ƽ���
% d ����������У�Ϊ��ʸ��
% COHERENCE  MFSK�Ľ������'coherent'/'noncoherent'
% �������
% s �������
% ref �ο�������

    if strcmpi(COHERENCE,'coherent')
        phi= zeros(1,M); %����ɼ�⣬phaseΪ0
        ref = complex(diag(exp(1i*phi)));
        s = complex(ref(d,:)); %����Ӱ�䵽��Ӧ�������� 
    else
        phi = 2*pi*rand(1,M);%M����(0,2pi)�ϵ������λ
        ref = diag(exp(1i*phi));
        s = ref(d,:);
    end
end