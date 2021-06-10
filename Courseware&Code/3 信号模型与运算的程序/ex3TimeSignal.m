clear
syms t
f=str2sym('(t/2+1)*(heaviside(t+2)-heaviside(t-2))')
subplot(2,1,1),ezplot(f,[-3,3])
y1=subs(f,t,t+2)
subplot(2,1,2),ezplot(y1,[-5,1])

