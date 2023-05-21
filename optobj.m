function f=optobj(T,lambda,d,c,h,A)
% objective function
% T is decision variable
clambdah=c*lambda+h;
dlambdaT=d./(lambda^2*T);
f= A./T + clambdah.*(dlambdaT.*(exp(lambda*T)-1)-d/lambda);
end