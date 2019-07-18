clear
clc
close all
ic=0:100;
Do1=100:-1:0;
figure
hold on
 
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
 
 
plot(ic,Do1,'k-','LineWidth',2)
plot(40,60,'ro','LineWidth',2)
 
set(gcf,'Position',[300 300 600 300], 'color','w')
axis([0 150 0 150])
axis off
box off
 
annotation('arrow',[0.13,0.95],[0.11,0.11])
annotation('arrow',[0.13,0.13],[0.11,0.97])
text(-2,-2,'0','FontSize',10,'FontWeight','bold','FontName','Times New Man','FontAngle','normal');
 
text(-7,100,'\sigma','FontSize',15,'FontWeight','normal','FontName','Times New Man','FontAngle','italic')
text(-4,97,'e','FontSize',8,'FontWeight','normal','FontName','Times New Man','FontAngle','italic')
 
text(-10,50,'\sigma','FontSize',15,'FontWeight','bold','FontName','Times New Man','FontAngle','normal','Rotation',90);
text(-8,55,'eqa','FontSize',8,'FontWeight','bold','FontName','Times New Man','FontAngle','normal','Rotation',90);
 
text(97,-3,'\sigma','FontSize',15,'FontWeight','normal','FontName','Times New Man','FontAngle','italic');
text(100,-5,'u','FontSize',8,'FontWeight','normal','FontName','Times New Man','FontAngle','italic');
 
text(50,-8,'\sigma','FontSize',15,'FontWeight','bold','FontName','Times New Man','FontAngle','normal');
text(54,-10,'eqm','FontSize',8,'FontWeight','bold','FontName','Times New Man','FontAngle','normal');
 
text(40,70,'(\sigma  ,\sigma )','FontSize',15,'FontWeight','normal','FontName','Times New Man','FontAngle','normal');
text(45,66,' m      a','FontSize',8,'FontWeight','normal','FontName','Times New Man','FontAngle','normal');
hold off
 
ic=0:100;
Do2=10.^(ic/10);
tt=1.3-0.16*log10(Do2); 

figure
hold on
plot(Do2,tt,'k-','LineWidth',2) 
set(gca,'xscale','log','yscale','linear','FontSize',8,'FontWeight','bold','FontName','Times New Man')

 
set(gcf,'Position',[300 300 600 300], 'color','w')
axis([10^0 10^10 0 1.5])
axis on
box off

annotation('arrow',[0.13,0.95],[0.11,0.11])
annotation('arrow',[0.13,0.13],[0.11,0.97])
 
text(10^-0.5,0.7,'Ratio r','FontSize',10,'FontWeight','bold','FontName','Times New Man','FontAngle','normal','Rotation',90);
text(10^4.5,-0.1,'Cycles N','FontSize',10,'FontWeight','bold','FontName','Times New Man','FontAngle','normal');

hold off
