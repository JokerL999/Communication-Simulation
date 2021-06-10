function [next_state,memory_contents]=get_next_state(current_state,input,L,k)
% ���ܣ��ɼĴ�����ǰ״̬�����룬ȷ���Ĵ�������һ��״̬�ʹ洢������
% ���룺current_state ��ǰ״̬ input ���� L��Լ������ k��ÿһʱ����������������ı�����
% �����next_state ��һ��״̬ memory_contents �Ĵ�������

binary_state=deci2bin(current_state,k*(L-1)); %��ʮ���Ʊ�ʾ��״̬ת�ض����ƣ���������ļĴ������ݸ���
binary_input=deci2bin(input,k); %��ʮ���Ʊ�ʾ�������ź�ת�ض����ƣ���������ļĴ������ݸ���
next_state_binary=[binary_input,binary_state(1:(L-2)*k)];%����һ״̬�У������뱣����Ĵ�����ͬʱ��������ݱ��Ƴ�
next_state=bin2deci(next_state_binary); %�ɼĴ������ݱ�ʾ����һ״̬��ת��ʮ���Ʊ�ʾ�Ĵ���״̬
memory_contents=[binary_input,binary_state]; %�������ݣ������������Լ��������Ƴ��ģ����ھ������