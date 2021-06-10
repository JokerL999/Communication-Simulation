clear
Nid=100000; 
for n=1:Nid
    X1=sqrt(2)*randn+1 ;
    X2=sqrt(9)*randn-2 ;
    X3=sqrt(4)*randn+0 ;
    Y(n)= X1+3*X2-2*X3;
end
mY=sum(Y)/Nid
vY=sum(Y.^2)/Nid-mY^2
