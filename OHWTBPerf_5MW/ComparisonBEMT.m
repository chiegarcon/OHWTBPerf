%==========================================================================
% OHWTBPerf 1.02                               []
%--------------------------------------------------------------------------

clear
close all
addpath(genpath([fullfile(cd),'\OHWTBfunctions'])); 
%Add directories to search path

main_dir = which('Blademain.m');
main_dir = main_dir(1:end-length('Blademain.m'));

blade_dir = [main_dir,'Results\OHWTBPerf\'];
bfname1 = [blade_dir,'OHWTBPerf_4_4_10.dat'];

topology1 = OHWTBData(bfname1,6,6,0);

wind_speed1 = topology1(:,1);
thrust1 = topology1(:,2);
torque1 = topology1(:,3);
power1 = topology1(:,4);
fbmax1 = topology1(:,6);

bfname2 = [blade_dir,'OHWTBPerf_0_0_0.dat'];

topology2 = OHWTBData(bfname2,6,6,0);

wind_speed2 = topology2(:,1);
thrust2 = topology2(:,2);
torque2 = topology2(:,3);
power2 = topology2(:,4);
fbmax2 = topology2(:,6);


blade_dir = [main_dir,'BladeData\ExistData\'];
bfname = [blade_dir,'speed2thrust.dat'];

topology = OHWTBData(bfname,2,3,0);
wind_speed = topology(:,1);
thrust = topology(:,2);

bfname = [blade_dir,'speed2torque.dat'];

topology = OHWTBData(bfname,2,3,0);

torque = topology(:,2);

bfname = [blade_dir,'speed2bending.dat'];

topology = OHWTBData(bfname,2,3,0);

fbmax = topology(:,2);

bfname = [blade_dir,'speed2power.dat'];

topology = OHWTBData(bfname,2,3,0);

power = topology(:,2);

figure
hold on

subplot(221);
hold on
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
set (gcf,'Position',[100 100 960 720], 'color','w')
%
plot(wind_speed,thrust,'k--^','LineWidth',1)

plot(wind_speed1,thrust1,'r-x','LineWidth',1);

plot(wind_speed2,thrust2,'b-o','LineWidth',1);

legend({'Experimental data','New corrected BEMT','Non-corrected BEMT'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest') 
title({'NREL 5MW wind turbine blade'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Wind speed [m/s]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Thrust [N]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([0 25 0 10e5])
legend boxoff
box on

subplot(222);
hold on
plot(wind_speed,torque,'k--^','LineWidth',1);
plot(wind_speed1,torque1,'r-x','LineWidth',1);
plot(wind_speed2,torque2,'b-o','LineWidth',1);


legend({'Experimental data','New corrected BEMT','Non-corrected BEMT'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest') 
title({'NREL 5MW wind turbine blade'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Wind speed [m/s]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Torque [N m]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([0 25 0 6e6])
legend boxoff
box on



subplot(223);
hold on

plot(wind_speed,fbmax,'k--^','LineWidth',1);
plot(wind_speed1,fbmax1,'r-x','LineWidth',1);
plot(wind_speed2,fbmax2,'b-o','LineWidth',1);

legend({'Experimental data','New corrected BEMT','Non-corrected BEMT'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest') 
title({'NREL 5MW wind turbine blade'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Wind speed [m/s]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Max Bending moment [N m]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([0 25 0 15e6])
legend boxoff
box on
hold off



subplot(224);
hold on

%
plot(wind_speed,power,'k--^','LineWidth',1);
plot(wind_speed1,power1,'r-x','LineWidth',1);
plot(wind_speed2,power2,'b-o','LineWidth',1);


legend({'Experimental data','New corrected BEMT','Non-corrected BEMT'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest') 
title({'NREL 5MW wind turbine blade'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
xlabel({'Wind speed [m/s]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Power [kW]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([0 25 0 8e3])
legend boxoff
box on
hold off

print -djpeg PerfCom.jpg