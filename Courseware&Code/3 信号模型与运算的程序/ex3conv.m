
n1=0:20; 
f1=0.8.^n1; 
n2=0:10; 
f2=(n2>=0);
f3=conv(f1,f2); 
subplot(3,1,1),
stem(n1,f1,'filled');%���������ͼ����Բ�㴦��ʵ��Բ��ʾ 
title('f1') 
subplot(3,1,2)
stem(n2,f2,'filled');%���������ͼ����Բ�㴦��ʵ��Բ��ʾ 
title('f2') 
subplot(3,1,3)
stem(f3,'filled');%���������ͼ����Բ�㴦��ʵ��Բ��ʾ 
title('f1���f2')


