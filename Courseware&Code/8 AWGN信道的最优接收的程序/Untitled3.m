      clear all, close all , clc
      sigma=1; % sigma is changed depending on the dispersion desired
      N=500;
      P1=sigma*randn(2,500)+[2;2]*ones(1,500);
      P2=sigma*randn(2,500)+[-2;-2]*ones(1,500);
      T1=ones(1,500);
      T2=zeros(1,500);
      %Data generation
      plot(P1(1,:),P1(2,:),'ro',P2(1,:),P2(2,:),'go')
      hold on
      %we generates the random values
      P=[P1,P2]; 
      T=[T1,T2];
      ind=randperm(2*N);
      P=P(:,ind);
      T=T(ind);
      Mx1 = mean(P1,2);
      Mx2 = mean(P2,2);
      for i=1:N
          p=P(:,i)
          s1= exp(-(p-Mx1)'*(p-Mx1)/(2*sigma^2)) % First Maximum Likelihood classifier 
          s2= exp(-(p-Mx2)'*(p-Mx2)/(2*sigma^2))
      end
      %For the last question here is the code of the function that defines the boundary:
      function []=frontiere(w,P,T,x)
      %--------------------------------------------------------------------------
      % function []=frontiere(W,P,T,x)
      % This function displays the border of classification determined by the Bayesian 
      %discriminant designed to separate between two distribution
      % W: weight matrices model
      % P: dataset
      % T: desired output (Target)
      % x: coordinates which determines the central position of distributions.
      %--------------------------------------------------------------------------
      %disp(' ')
      %disp(' Determining the decision boundary')
      %disp(' ')
      X = [-x:0.02:x]; Y = [-x:0.02:x];
      for i=1:size(X,2)
      for j=1:size(Y,2)
      p = [X(i);Y(j)];
      % IN THIS PART WE MUST IMPLEMENT THE BAYESIAN DISCRIMINANT
      % a2 = output of Bayes classifier
      end
      end
      plotpv(P,T==1);
      hold on
      contour(X,Y,a2,1);
      drawnow
      end