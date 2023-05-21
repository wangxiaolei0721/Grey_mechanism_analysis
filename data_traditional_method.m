% clear data and figure
clc;
clear;
close all;
% load data
load data.mat
Q=800; % initial inventory
t=[0:7]';
i_t_data=i_t_data';
l=length(i_t_data);
i_t_cum=Q+cumsum(i_t_data);  % accumulative series
z1=(i_t_cum(2:end)+i_t_cum(1:end-1))/2; % neighbor mean series
% plot original and cumulative series
fig=figure('unit','centimeters','position',[5,5,25,10],'PaperPosition',[5, 5, 25,10],'PaperSize',[25,10]);
tile=tiledlayout(1,2,'Padding','Compact');
nexttile
plot(t(2:end),i_t_data,'LineStyle','--','Marker','*','MarkerSize',6,'LineWidth',1.5)
xlabel({'Day'},'FontSize',14);
ylabel(['Inventory change'],'FontSize',14)
title({' (a) Inventory change $i(t)$'},'FontSize',16,'Interpreter','latex');
set(gca,'FontName','Book Antiqua','FontSize',12,'Xlim',[0.5,7.5]);
nexttile
plot(t(2:end),i_t_cum,'LineStyle','--','Marker','*','MarkerSize',6,'LineWidth',1.5,'Color',[217, 83, 25]/255);
xlabel({'Day'},'FontSize',14);
ylabel(['Inventory level'],'FontSize',14)
title({' (b) Inventory level $I(t)$'},'FontSize',16,'Interpreter','latex');
set(gca,'FontName','Book Antiqua','FontSize',12,'Xlim',[0.5,7.5]);
savefig(gcf,'.\figure\grey_traditional_method_cum.fig');
exportgraphics(gcf,'.\figure\grey_traditional_method_cum.pdf')
% estimate parameter
B=[z1,ones(l-1,1)];
Y=i_t_data(2:end);
p=(B'*B)\B'*Y;
lambda=-p(1);
d=-p(2);
save('estimates_traditional_method.mat','lambda','d')
% time sponse function
k=[0:l]';
c=Q+d/lambda;
I_t_sim=c*exp(-lambda*k)-d/lambda;
% plot fitted curve
fig1=figure;
plot(t,[Q;i_t_cum],'LineStyle','none','Marker','*','MarkerSize',6,'LineWidth',1.5)
hold on
plot(t,I_t_sim,'LineStyle','--','LineWidth',1.5)
xlabel({'Day'},'FontSize',14);
ylabel(['Inventory level'],'FontSize',14)
set(gca,'FontName','Book Antiqua','FontSize',12,'Xlim',[-0.5,7.5],'Ylim',[0,850]);
legend(["Actual level","Fitted curve"],'location','northeast','FontSize',12,'NumColumns',1);
% save figure
savefig(fig1,'.\figure\grey_traditional_method.fig');
exportgraphics(fig1,'.\figure\grey_traditional_method.pdf')
