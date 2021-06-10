
n1=0:20; 
f1=0.8.^n1; 
n2=0:10; 
f2=(n2>=0);
f3=conv(f1,f2); 
subplot(3,1,1),
stem(n1,f1,'filled');%绘制脉冲杆图，且圆点处用实心圆表示 
title('f1') 
subplot(3,1,2)
stem(n2,f2,'filled');%绘制脉冲杆图，且圆点处用实心圆表示 
title('f2') 
subplot(3,1,3)
stem(f3,'filled');%绘制脉冲杆图，且圆点处用实心圆表示 
title('f1卷积f2')


