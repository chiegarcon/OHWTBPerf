%==========================================================================
% OHWTBPerf 1.02                               [Plot Lift, Drag & PM Coeff]
%--------------------------------------------------------------------------

[alpha_stall1,alpha1,CL1,CD1,CM141]=AlphaLiftDrag(3);
[alpha_stall2,alpha2,CL2,CD2,CM142]=AlphaLiftDrag(4);
[alpha_stall3,alpha3,CL3,CD3,CM143]=AlphaLiftDrag(5);
[alpha_stall4,alpha4,CL4,CD4,CM144]=AlphaLiftDrag(6);
[alpha_stall5,alpha5,CL5,CD5,CM145]=AlphaLiftDrag(7);
[alpha_stall6,alpha6,CL6,CD6,CM146]=AlphaLiftDrag(8);

figure
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
set (gcf,'Position',[100 000 900 1200], 'color','w')
subplot(3,2,1)
plot(alpha1,CL1,'r-','LineWidth',2);
hold on

%
plot(alpha1,CD1,'k--','LineWidth',2,'MarkerSize',8)
plot(alpha1,CM141,'b-.','LineWidth',2,'MarkerSize',8)

legend({'C_l','C_d','C_{M1/4}'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','southwest') 
title({'DU21\_A17'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Attack angle [\circ]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Lift, Drag & PM Coeff [-]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([-180 180 -1.5 2])
legend boxoff
box on
hold off

subplot(3,2,2)
plot(alpha2,CL2,'r-','LineWidth',2);
hold on

%
plot(alpha2,CD2,'k--','LineWidth',2,'MarkerSize',8)
plot(alpha2,CM142,'b-.','LineWidth',2,'MarkerSize',8)

legend({'C_l','C_d','C_{M1/4}'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','southwest') 
title({'DU25\_A17'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Attack angle [\circ]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Lift, Drag & PM Coeff [-]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([-180 180 -1.5 2])
legend boxoff
box on
hold off

subplot(3,2,3)
plot(alpha3,CL3,'r-','LineWidth',2);
hold on

%
plot(alpha3,CD3,'k--','LineWidth',2,'MarkerSize',8)
plot(alpha3,CM143,'b-.','LineWidth',2,'MarkerSize',8)

legend({'C_l','C_d','C_{M1/4}'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','southwest') 
title({'DU30\_A17'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Attack angle [\circ]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Lift, Drag & PM Coeff [-]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([-180 180 -1.5 2])
legend boxoff
box on
hold off

subplot(3,2,4)
plot(alpha4,CL4,'r-','LineWidth',2);
hold on

%
plot(alpha4,CD4,'k--','LineWidth',2,'MarkerSize',8)
plot(alpha4,CM144,'b-.','LineWidth',2,'MarkerSize',8)

legend({'C_l','C_d','C_{M1/4}'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','southwest') 
title({'DU35\_A17'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Attack angle [\circ]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Lift, Drag & PM Coeff [-]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([-180 180 -1.5 2])
legend boxoff
box on
hold off

subplot(3,2,5)
plot(alpha5,CL5,'r-','LineWidth',2);
hold on

%
plot(alpha5,CD5,'k--','LineWidth',2,'MarkerSize',8)
plot(alpha5,CM145,'b-.','LineWidth',2,'MarkerSize',8)

legend({'C_l','C_d','C_{M1/4}'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','southwest') 
title({'DU40\_A17'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Attack angle [\circ]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Lift, Drag & PM Coeff [-]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([-180 180 -1.5 2])
legend boxoff
box on
hold off

subplot(3,2,6)
plot(alpha6,CL6,'r-','LineWidth',2);
hold on

%
plot(alpha6,CD6,'k--','LineWidth',2,'MarkerSize',8)
plot(alpha6,CM146,'b-.','LineWidth',2,'MarkerSize',8)

legend({'C_l','C_d','C_{M1/4}'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','southwest') 
title({'NACA\_64\_618'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Attack angle [\circ]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Lift, Drag & PM Coeff [-]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([-180 180 -1.5 2])
legend boxoff
box on
hold off

print -djpeg AirfoilsCOM.jpg