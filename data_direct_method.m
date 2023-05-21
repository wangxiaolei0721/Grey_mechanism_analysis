% clear data and figure
clc;
clear;
close all;
% 
load data.mat
Q=800;
% start
t=[0:7]';
I_t_data=I_t_data';
I_t_data_Q=[Q;I_t_data];
l=length(I_t_data);
I1_cumsum=cumsum(I_t_data_Q(1:end-1,1));
I2_cumsum=cumsum(I_t_data_Q(2:end,1));
I_t_cum=1/2*I1_cumsum+1/2*I2_cumsum;  % accumulative series
% estimate parameter
time0=[2:l]';
% B=[I_t_cum(2:end,1),time0,ones(l-1,1)];
B=[I_t_cum(2:end,1),time0];
Y=I_t_data(2:end,1)-Q;
p=pinv(B'*B)*B'*Y;
lambda=-p(1);
d=-p(2);
save('estimates_direct_method.mat','lambda','d')
% time sponse function
k=[0:l]';
c=Q+d/lambda;
I_t_sim=c*exp(-lambda*k)-d/lambda;
% plot figure
fig1=figure;
plot(t,I_t_data_Q,'LineStyle','none','Marker','*','MarkerSize',6,'LineWidth',1.5)
hold on
plot(t,I_t_sim,'LineStyle','--','LineWidth',1.5)
xlabel({'Day'},'FontSize',14);
ylabel(['Inventory level'],'FontSize',14)
set(gca,'FontName','Book Antiqua','FontSize',12,'Xlim',[-0.5,7.5],'Ylim',[0,850]);
legend(["Actual level","Fitted curve"],'location','northeast','FontSize',12,'NumColumns',1);
% save figure
savefig(fig1,'.\figure\grey_direct_method.fig');
exportgraphics(fig1,'.\figure\grey_direct_method.pdf')