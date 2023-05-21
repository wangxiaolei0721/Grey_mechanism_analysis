% clear data and figure
clc;
clear;
close all;
% parameter
c=5;
h=0.1;
A=300;
%% 
% load data
load estimates_traditional_method.mat
% 0.618 method
a=1;
b=10;
L=0.01;
p=a+0.382*(b-a);
q=a+0.618*(b-a);
while (b-a>L)
      s=optobj(p,lambda,d,c,h,A)-optobj(q,lambda,d,c,h,A);
   if s>0 
       a=p;
       b=b;
       p=q;
       q=a+0.618*(b-a);
   else 
         a=a;
         b=q;
         q=p;
         p=a+0.382*(b-a);
   end
  
end
T_opt=(b+a)/2;
obj_opt=optobj(T_opt,lambda,d,c,h,A);
save('T_grey_traditional_method','T_opt','obj_opt')
%% optimize
T=[1:0.1:10];
clambdah=c*lambda+h;
dlambdaT=d./(lambda^2*T);
f= A./T + clambdah.*(dlambdaT.*(exp(lambda*T)-1)-d/lambda);
plot(T,f,'LineStyle','-','LineWidth',1.5)
hold on
plot(T_opt,obj_opt,'Color',[217, 83, 25]/255,'Marker','*','MarkerSize',8,'LineWidth',1)
xticks([1:10])
xlabel({'Day'},'FontSize',14);
ylabel(['Cost'],'FontSize',14)
title({'(a) The traditional method'},'FontSize',16);
set(gca,'FontName','Book Antiqua','FontSize',12,'Xlim',[0.5,10.5]);
%%
T_star=3;
Q_star=d/lambda*(exp(lambda*T_star)-1);
% save figure
savefig(gcf,'.\figure\grey_traditional_opt.fig');
exportgraphics(gcf,'.\figure\grey_traditional_opt.pdf')