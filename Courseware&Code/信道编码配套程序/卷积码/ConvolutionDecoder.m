function [decoder_output,survivor_state,cumulated_metric]=ConvolutionDecoder(G,k,decoder_input)
% ���ܣ�������Viterbi������
% ���룺G ���ɾ��� k ÿһʱ����������������ı����� decoder_input ����������
% �����decoder_output ���������survivor_state �Ҵ�·�� cumulated_metric �ۻ�����ֵ
 
n=size(G,1); % n ��������˿�����,(n,k,m)��n=2
if rem(size(G,2),k) ~=0 
  error('����G��������k��ƥ��') %G����ӦΪk�ı�����ÿk����Ϣ���n�����ȵ����֣�
end
if rem(size(decoder_input,2),n) ~=0
  error('����G��������������г��Ȳ�ƥ��') %�������еĳ���ӦΪG�����ı���
end

L=size(G,2)/k; %Լ�����ȣ�Ҳ���Ĵ����ĸ���
M=2^k;         %�����źŵĸ�����ÿ��״̬�����ķ�֧����
number_of_states=2^((L-1)*k);% �Ĵ�����״̬��������ͼ��������

input=zeros(number_of_states,number_of_states); %����ÿ��״̬���з�֧�������ź�
nextstate=zeros(number_of_states,M); %����ÿ��״̬���з�֧����һ״̬
output=zeros(number_of_states,M); %����ÿ��״̬���з�֧�ı�������ź�

% ����״̬ת�ƾ�����һ״̬�������������������
% ע�⣺״̬�������������Ǵ�0��ʼ��ţ���matlab����ֻ֧�ִ�1��ʼ���������洢��Ŷ���+1
for j=0:number_of_states-1 %����״̬�ö��������б�ʾ��Ϊ���淽�㣬������ʮ���Ʊ�ʾ
    for m=0:M-1   %���������ź��ö��������б�ʾ��Ϊ���淽�㣬������ʮ���Ʊ�ʾ
        [next_state,memory_contents]=get_next_state(j,m,L,k);
        %ע�⣺memory_contents�����������Լ���������һ״̬���Ƴ�����ʷ���ݣ���������ľ������
        input(j+1,next_state+1)=m;%ʮ���Ʊ�ʾ�������ź�
        branch_output=rem(memory_contents*G',2); %�������������
        nextstate(j+1,m+1)=next_state;%ʮ���Ʊ�ʾ����һ״̬
        output(j+1,m+1)=bin2deci(branch_output);%����������ʮ���Ʊ�ʾ
    end
end

state_metric=zeros(number_of_states,2);  % ��¼���������ÿ��״̬�Ķ���ֵ���������ŷʽ�ࣩ
%state_metric��:,1����ǰ״̬λ�õĶ���ֵ��Ϊȷ��ֵ������:,2��Ϊ��ǰ״̬������õ�����һ��״̬����ֵ��Ϊ��ʱֵ
depth_of_trellis=length(decoder_input)/n; % ������ȣ�Ҳ��������ͼ�е�������
decoder_input_matrix=reshape(decoder_input,n,depth_of_trellis);% �������������иĳ�ÿ��n��Ԫ�صľ��󣬱��ں���ķ�֧����ֵ�ļ���
survivor_state=zeros(number_of_states,depth_of_trellis); %�����Ҵ�·����Ҳ��·����ÿ��״̬��ǰһ״̬

% ��β�����ص�����
for i=1:depth_of_trellis-L+1 %�Գ����L-1��������ؽ�������
    flag=zeros(1,number_of_states); % ״̬�����ʵı��
    %������ͼ�У�����ÿһ��������Ϣ��״̬����1��2��4...��number_of_states/2��number_of_states
    %step��������״̬���ı仯 
    if i <= L  
        step=2^((L-i)*k);
    else
        step=1;
    end
    
    for j=0:step:number_of_states-1 % �����״̬���
        for m=0:M-1 %��ÿ�������״̬����̽���ܵ�������Ϣ
            binary_output=deci2bin(output(j+1,m+1),n);%������״̬j�£���������Ϣm��������ͼ�ϵõ���Ӧ�ı��������
            %������n�������������������ֶ���ֵ(������)
            branch_metric=sum(decoder_input_matrix(:,i)~=binary_output');
            %ѡ���������С������·��
            %ѡ�񷽷�������һ��״̬next_stateû�б�����ʱ��ֱ�Ӹ�ֵ(֮ǰû�з�֧������ѡ��)�������ñ���С�Ľ��串��
            %ע�⣺���ǵ�ԭ����һ��״̬�����ɶ��״̬���state_metric(next_state+1,2)���������ǰ��õĶ���ֵ��Сֵ
            %      �����γ��Է��ָ�С�Ķ���ֵ��state_metric(j+1,1)+branch_metric��������ζ�������̽��·������
            %      ��ˣ���next_state�����֧��Ϊj��Ҳ������j״̬����ģ��������¶���ֵ
            next_state=nextstate(j+1,m+1);%ԭ������ͼ��¼������·���µ���һ״̬
            if((state_metric(next_state+1,2) > state_metric(j+1,1)+branch_metric) || flag(next_state+1)==0)
                state_metric(next_state+1,2) = state_metric(j+1,1)+branch_metric;
                %survivor_state(next_state+1,i+1)=j;
                survivor_state(next_state+1,i)=j;
                flag(next_state+1)=1;
            end
        end
    end
    state_metric(:,1)=state_metric(:,2);%��state_metric��:,1������Ϊstate_metric��:,2��
end

%  β���ص�����.
for i=depth_of_trellis-L+2:depth_of_trellis
    flag=zeros(1,number_of_states); %״̬�����ʵı��
    %������ͼ�У�β��������ʱ������ÿһ��������Ϣ��״̬����number_of_states��number_of_states/2��...��2��1
    %last_stop��������״̬���ı仯 
    last_stop=number_of_states/(2^((i-depth_of_trellis+L-2)*k));
    for j=0:last_stop-1
        binary_output=deci2bin(output(j+1,1),n);
        %������n�������������������ֶ���ֵ(������)
        branch_metric=sum(decoder_input_matrix(:,i)~=binary_output');
        %�����ڷ�β���ص����룬����Ϊ��β�������룬β���ض���0����һ״̬������̶���0��֧
        next_state=nextstate(j+1,1);
        if((state_metric(next_state+1,2) > state_metric(j+1,1)+branch_metric) || flag(next_state+1)==0)
            state_metric(next_state+1,2) = state_metric(j+1,1)+branch_metric;
            %survivor_state(next_state+1,i+1)=j;
            survivor_state(next_state+1,i)=j;
            flag(next_state+1)=1;
        end
    end
    state_metric(:,1)=state_metric(:,2);%��state_metric��:,1������Ϊstate_metric��:,2��
end

% ����survivor_state�ҳ��Ҵ�·��
state_sequence=zeros(1,depth_of_trellis+1); % ��������·���ϵ�ÿ�������Ӧ��״̬
state_sequence(1,depth_of_trellis)=survivor_state(1,depth_of_trellis);
for i=1:depth_of_trellis
    previous_state=state_sequence(1,depth_of_trellis+2-i); % �Ҵ�·���е�ǰ״̬��ǰһ״̬
    state_sequence(1,depth_of_trellis-i+1)=survivor_state(previous_state+1,depth_of_trellis-i+1);
end

% �������
decoder_output_matrix=zeros(k,depth_of_trellis-L+1);%ע�⣺ֻ�����β����
for i=1:depth_of_trellis-L+1
    dec_output_deci=input(state_sequence(1,i)+1,state_sequence(1,i+1)+1);%���ݵ�ǰ״̬����һ״̬���õ�������Ϣ����
    dec_output_bin=deci2bin(dec_output_deci,k);
    decoder_output_matrix(:,i)=dec_output_bin(k:-1:1)';
end
decoder_output=reshape(decoder_output_matrix,1,k*(depth_of_trellis-L+1)); %������
cumulated_metric=state_metric(1,1);
