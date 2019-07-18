%==========================================================================
% OHWTBPerf 1.02 by CHIZHI                              [OHWTBAerofoils.m]
%--------------------------------------------------------------------------

function [alpha_stall,alpha,CL,CD,CM14] = OHWTBAerofoils(airfoil_no)

main_dir = which('OHWTBMain.m');
main_dir(length(main_dir)-10:length(main_dir)) = [];
aero_dir = [main_dir,'BladeData\Aerodynamics\'];

% The data files below are located at:
% X:\...\OHWTBPerf_5MW)\Aerodynamics

if airfoil_no == 1, bfname = [aero_dir,'Circular1.dat']; end
if airfoil_no == 2, bfname = [aero_dir,'Circular2.dat']; end
if airfoil_no == 3, bfname = [aero_dir,'DU40_A17.dat']; end
if airfoil_no == 4, bfname = [aero_dir,'DU35_A17.dat']; end
if airfoil_no == 5, bfname = [aero_dir,'DU30_A17.dat']; end
if airfoil_no == 6, bfname = [aero_dir,'DU25_A17.dat']; end
if airfoil_no == 7, bfname = [aero_dir,'DU21_A17.dat']; end
if airfoil_no == 8, bfname = [aero_dir,'NACA_64_618.dat']; end
 
[stall] = OHWTBData(bfname,3,1,0);
alpha_stall = stall(:,1);

[aero] = OHWTBData(bfname,4,5,0);
alpha = aero(:,1);
CL = aero(:,2);
CD = aero(:,3);
CM14 = aero(:,4);

fclose('all');

%==========================================================================

