clear
close all

addpath(genpath([fullfile(cd),'\OHWTBfunctions'])); 
%Add directories to search path

main_dir = which('Blademain.m');
main_dir = main_dir(1:end-length('Blademain.m'));

blade_dir = [main_dir,'BladeData\ExistData\'];
bfname = [blade_dir,'speed2stress.dat'];

topology = OHWTBData(bfname,4,3,0);
wind_speed = topology(:,2);
stress = topology(:,4);

figure
hold on
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
set (gcf,'Position',[100 100 600 450], 'color','w')
%
plot(wind_speed,stress,'kx','LineWidth',2,'MarkerSize',8)
plot(wind_speed,stress,'b-','LineWidth',2);

legend({'FE model results','Fitting curve'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest') 
title({'NREL 5MW wind turbine blade'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Wind speed [m/s]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Stress [MPa]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([0 30 0 150])
legend boxoff
box on
hold off
print -djpeg WindStress.jpg