%==========================================================================
% OHWTBPerf 1.02                                  [Loss factor comparision]
%--------------------------------------------------------------------------

clear
close all
clc

B=3;
R=63;

r_hub=1.5;
phi=0.3;
lamda_r=1;
F=zeros(1);
c=zeros(1);

figure
hold on
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
set (gcf,'Position',[100 100 600 300], 'color','w')



tip_loss_model=0;
hub_loss_model=0;

j=1;
r=1.5;

while r <=63
    
    F(j) = OHWTBLoss(B,R,r,r_hub,phi,lamda_r,tip_loss_model,hub_loss_model);
    
    c(j)=(r-1.5)/(R-1.5);
    
    j=j+1;
    
    r=r+0.5;
    
end



plot(c,F,'k:','LineWidth',2)

tip_loss_model=1;
hub_loss_model=1;

j=1;
r=1.5;

while r <=63
    
    F(j) = OHWTBLoss(B,R,r,r_hub,phi,lamda_r,tip_loss_model,hub_loss_model);
    
    c(j)=(r-1.5)/(R-1.5);
    
    j=j+1;
    
    r=r+0.5;
    
end



plot(c,F,'r-','LineWidth',2)

tip_loss_model=2;
hub_loss_model=2;

j=1;
r=1.5;

while r <=63
    
    F(j) = OHWTBLoss(B,R,r,r_hub,phi,lamda_r,tip_loss_model,hub_loss_model);
    
    c(j)=(r-1.5)/(R-1.5);
    
    j=j+1;
    
    r=r+0.5;
    
end



plot(c,F,'y-.','LineWidth',2)

tip_loss_model=3;
hub_loss_model=3;

j=1;
r=1.5;

while r <=63
    
    F(j) = OHWTBLoss(B,R,r,r_hub,phi,lamda_r,tip_loss_model,hub_loss_model);
    
    c(j)=(r-1.5)/(R-1.5);
    
    j=j+1;
    
    r=r+0.5;
    
end



plot(c,F,'b-.','LineWidth',2)

tip_loss_model=4;
hub_loss_model=4;

j=1;
r=1.5;

while r <=63
    
    F(j) = OHWTBLoss(B,R,r,r_hub,phi,lamda_r,tip_loss_model,hub_loss_model);
    
    c(j)=(r-1.5)/(R-1.5);
    
    j=j+1;
    
    r=r+0.5;
    
end



plot(c,F,'m--','LineWidth',2)


tip_loss_model=5;
hub_loss_model=5;

j=1;
r=1.5;

while r <=63
    
    F(j) = OHWTBLoss(B,R,r,r_hub,phi,lamda_r,tip_loss_model,hub_loss_model);
    
    c(j)=(r-1.5)/(R-1.5);
    
    j=j+1;
    
    r=r+0.5;
    
end



plot(c,F,'g-.','LineWidth',2)


xlabel('Radius ratio, r/R','FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel('Total loss factor, F','FontSize',10,'FontWeight','bold','FontName','Times New Man')

legend({'No loss correction',...
    'Prandtl''s loss correction (1963)',...    
    'Xu & Sankar''s loss correction (2002)',...
    'Shen''s loss correction (2005)'...
    'New loss correction (2018)'...
    'Goldstein''s loss correction (2008)'},...
    'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','southwest')
axis([0 1 0 1])
legend boxoff
box on