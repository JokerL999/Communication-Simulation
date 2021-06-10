
a=[-10,-5,-4,-2,0,1,3,5,10];
syms x ;
y=1/(sqrt(2*pi))*exp(-x^2/2);
y1=x/(sqrt(2*pi))*exp(-x^2/2);
digits(5)
for i=1:length(a)-1
 y_actual(i)=vpa(int(y1,a(i),a(i+1))/int(y,a(i),a(i+1)));
end
y_actual

