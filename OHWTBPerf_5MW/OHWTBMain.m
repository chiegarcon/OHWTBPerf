%==========================================================================
% OHWTBMain v1.02 by Chizhi
% Main Program                                                [OHWTBMain.m]
%--------------------------------------------------------------------------

clear
clc
close all

addpath(genpath([fullfile(cd),'\OHWTBfunctions'])); 
%Add directories to search path

% Information of OHWTBPerf

fprintf('==================\n')
fprintf('OHWTBMain V1.02\n')
fprintf('==================\n')
fprintf('Author     : Chizhi Zhang\n')
fprintf('Supervisor : Dr Kong Fah Tee\n')
fprintf('Institution: Department of Engineering and Sciences,\n')
fprintf('             University of Greenwich, United Kingdom\n')
fprintf('Supervisor : Prof Chen and Dr Wang\n\n')

% rad to degree and vice versa 

d2r = pi/180; r2d = 1/d2r;

%------------------------ Geometry  Conditions ---------------------------

% Number of Blades
B = 3;

% Blade length, m
R = 63;

% Hub radius, m
r_hub = 1.5;

L_blade=R-r_hub;

% Pitch angle
pitch_angle_model = 1; % deg
pitch_angle_fix = 0;

% Precone angle
conning_angle = 2.5; % deg
delta = conning_angle*d2r; % Precone angle, rad

% Rotor speed
rotor_speed_model = 1; % rpm
rotor_speed_fix = 12.1;

%---------------------- Gerneral BEMT Conditions --------------------------

% Max iteration
max_iter=200;

% Error tolerance for BEMT iteration
tolerance = 0.000001;

%--------------------------- Wind Conditions -----------------------------

% Air density, kg/m^3
rho=1.225;

% Cut-in speed, m/s
Vcut_in=3;

% Increment of speed, m/s
Vstep=1;

% Cut-out speed, m/s
Vcut_out=25;

% Increment number of speed, m/s
Viter=(Vcut_out-Vcut_in)/Vstep +1;

% Average wind speed, m/s
V_avg=11.2;

use_drag_term=1;

%--------------------------- BEMT Corrections -----------------------------

for tip_loss_model=4:4

hub_loss_model=tip_loss_model;

for brake_state_model=10:10
%--------------------------------------------------------------------------
% Load blade topology from "BladeGeom.dat" file which contained
% Table of station no., r, c, Twist angle, airfoil no.

main_dir = which('OHWTBMain.m');
main_dir = main_dir(1:end-length('OHWTBMain.m'));

blade_dir = [main_dir,'BladeData\BladeGeom\'];
bfname = [blade_dir,'BladeGeomJonl.dat'];

topology = OHWTBData(bfname,6,3,0);
blade_station = topology(:,1);
r = topology(:,2);
beta = topology(:,3);
dr = topology(:,4);
c = topology(:,5);
af_number = topology(:,6);

n_seg = length(blade_station);


%--------------------------------------------------------------------------
% Load blade topology from "WindSR.dat" file which contained
% Table of pre-design pitch angel and rot speed.

bfname = [blade_dir,'WindSR2.dat'];

topology = OHWTBData(bfname,3,3,0);
Windsp = topology(:,1);
rotsp = topology(:,2);
pitchag = topology(:,3);

%==========================================================================

lastupdate_BEMT = clock - 1;
starttime_BEMT = clock;

WaitBEMT = waitbar(0,'',...
    'Name','OHWTBPerf v1.02 by CHIZHI',...
    'Unit','normalized',...
    'Position',[0.360 0.589 0.255 0.080]);

fprintf('===============================================\n')
fprintf('       Wind Turbine Blade Performance          \n')
fprintf('-----------------------------------------------\n')
fprintf('   Vw      T       Q      P       Cp     FBmax \n')
fprintf(' (m/s)   (kN)   (kN-m)   (kW)     (-)    (kN-m)\n')
fprintf('-----------------------------------------------\n')

wind_speed = zeros(1,Viter);
thrust = zeros(1,Viter);
torque = zeros(1,Viter);
power = zeros(1,Viter);
power_coefficient = zeros(1,Viter);
max_flap_at_hub = zeros(1,Viter);


matrix_alpha = zeros(1,Viter);
matrix_CL = zeros(1,Viter);
matrix_CD = zeros(1,Viter);
matrix_CM14 = zeros(1,Viter);
matrix_Vrel = zeros(1,Viter);
matrix_phi = zeros(1,Viter);
matrix_dT = zeros(1,Viter);
matrix_dQ = zeros(1,Viter);


iter_Vw = 0;

for Vw = Vcut_in : Vstep : Vcut_out % Wind speed loop
    
    iter_Vw = iter_Vw+1;
    BEMT_done = (Vw-Vcut_in)/(Vcut_out-Vcut_in);
    runtime_BEMT = etime(clock,starttime_BEMT);
    timeleft_BEMT = runtime_BEMT/BEMT_done-runtime_BEMT;
    timeleftstr_BEMT = OHWTBString(timeleft_BEMT);
    titlebarstr_BEMT = sprintf('OHWTBPerf is estimating %s remaining (%3.1f%%)',...
        timeleftstr_BEMT,BEMT_done*100);
    set(WaitBEMT,'Name',titlebarstr_BEMT)
    waitbar(BEMT_done,WaitBEMT,...
        sprintf('%3.1f          Wind Speed =%4.1f m/s   for %4.0f %4.0f               %3.1f',Vcut_in,Vw,tip_loss_model,brake_state_model,Vcut_out))
    
    %   Start analysis
    
    WaitSegment = waitbar(0,'',...
        'Name',sprintf('Wind Speed =%3.1f m/s',Vw),...
        'Unit','normalized',...
        'Position',[0.360 0.400 0.255 0.080]);
    
    if pitch_angle_model==0
        
        pitch_angle=pitch_angle_fix;
        
    else
        
        pitch_angle=interp1(Windsp,pitchag,Vw,'linear');
        
    end
    
    pitch = pitch_angle*d2r; % Pitch angle, rad
    
    if rotor_speed_model==0
        
        rotor_speed=rotor_speed_fix;
       
    else
        rotor_speed=interp1(Windsp,rotsp,Vw,'linear');
    end
    
     omega = 2*pi*rotor_speed/60; % Angular velocity of rotor, rad/s
    
    T = 0; Q = 0; P = 0; FB_max = 0;
    
    
    for i = 1 : n_seg % Segment loop
        
        segment_done = (i-1)/(n_seg-1);
        waitbar(segment_done,WaitSegment,...
            sprintf('Applying BEMT to segment %i of %i',i,n_seg))
        
        
        [alpha_stall,alpha_table,CL_table,CD_table,CM14_table] = OHWTBAerofoils(af_number(i));
        
        %           Solidity ratio
        sigma = B*c(i)/(2*pi*r(i)*cos(delta));            % Eq. (2.2-1)
        
        %           Local speed ratio
        lamda_r = omega*r(i)*cos(delta)/Vw;               % Eq. (2.7-8)
        
        a1 = .0; ap1 = .0;
        
        converge = true;
        
        %           Start of Iteration Loop
        
        iter = 0;
        
        while converge % BEMT
            
            iter = iter+1;
            
            %               Inflow angle
            phi = atan((1-a1)*Vw/(omega*r(i)*(1+ap1))); % rad
            %
            
            alpha = OHWTBAngle(beta(i),phi,pitch);
            
            %               Total loss factor
            F = OHWTBLoss(B,R,r(i),r_hub,phi,...
                lamda_r,tip_loss_model,hub_loss_model);  % TotalLossFactor.m
            
            %               Lift, drag and pitching coefficients
            CL = interp1(alpha_table,CL_table,alpha,'spline');
            CD = interp1(alpha_table,CD_table,alpha,'spline');
            CM14 = interp1(alpha_table,CM14_table,alpha,'spline');
            
            %               New values of axial and tangential induction factors
            [a2,ap2] = OHWTBWake(B,c(i),r(i),sigma,F,delta,phi,...
                CL,CD,a1,use_drag_term,brake_state_model);
            % BrakeStateModel.m

            if a2 >= 1
                
                fprintf('WARNING! >>> a2>=1 occurs when Vw = %3.1f m/s at Segment No. %i [not serious] <<<\n',Vw,i)
                
            end
            
            if isreal(a2)==0  || isreal(a1)==0 || isreal(ap2)==0 || isreal(ap1)==0 
                
                pause
                
            end
            
            [a1,ap1,converge] = OHWTBChange(a1,ap1,a2,ap2,tolerance);
            
            if iter >= max_iter
                
                fprintf('WARNING! >>> Loop jumping occurs when Vw = %3.1f m/s at Segment No. %i [not serious] <<<\n',Vw,i)
                break;
                
            end
            
        end
        
        %           Wind turbine characteristics
        %
        Vrel = sqrt((Vw*(1-a1)*cos(delta))^2+...
            (r(i)*omega*(1+ap1)*cos(delta))^2); % m/s       Eq. (2.2-6)
        
        dT = 1/2*rho*B*c(i)*Vrel^2*...
            (CL*cos(phi)+CD*sin(phi))*cos(delta)*dr(i); % N                           Eq. (2.5-7)
        %         dT=4*pi*rho*Vw*Vw*a1*(1-a1)*r(i)*dr(i);
        dQ = 1/2*rho*B*c(i)*Vrel^2*...
            (CL*sin(phi)-CD*cos(phi))*r(i)*cos(delta)*dr(i); % N-m                   Eq. (2.5-10)
        %         dQ=4*pi*rho*omega*Vw*ap1*(1-a1)*r(i)^3*dr(i);
        dP = dQ*omega/1000; % kW                            Eq. (2.6-7)
        
        dFB_max = dT*r(i); % N-m
        
        T = T+dT;                                   % Eq. (2.6-8)
        Q = Q+dQ;                                   % Eq. (2.6-9)
        P = P+dP;                                  % Eq. (2.6-10)
        FB_max = FB_max+dFB_max/B;
        
        matrix_alpha(i,iter_Vw) = alpha;
        matrix_CL(i,iter_Vw) = CL;
        matrix_CD(i,iter_Vw) = CD;
        matrix_CM14(i,iter_Vw) = CM14;
        matrix_Vrel(i,iter_Vw) = Vrel;
        matrix_phi(i,iter_Vw) = phi;
        matrix_dT(i,iter_Vw) = dT;
        matrix_dQ(i,iter_Vw) = dQ;
        
        CP = P*1000/(0.5*rho*Vw^3*pi*(R*cos(delta))^2);
    end
    
    fprintf('%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.3f\n',Vw,T,Q,P,CP,FB_max)
    
    wind_speed(iter_Vw) = Vw;
    thrust(iter_Vw) = T;
    torque(iter_Vw) = Q;
    power(iter_Vw) = P;
    power_coefficient(iter_Vw) = CP;
    max_flap_at_hub(iter_Vw) = FB_max;
    
    
    close(WaitSegment)
end

fclose('all');
close(WaitBEMT)

% Annual Energy Production (AEP) at annual average wind speed at site
[P_avg,AEP] = OHWTBResult(iter_Vw,power,wind_speed,thrust,torque,power,...
    power_coefficient,max_flap_at_hub,Vstep,V_avg,main_dir,tip_loss_model,hub_loss_model,brake_state_model);

%Performance

[L,D,M14,FX,FY,MZ] = OHWTBForce(rho,c,matrix_Vrel,matrix_CL,...
    matrix_CD,matrix_CM14,matrix_phi,iter_Vw,n_seg,dr,main_dir,tip_loss_model,hub_loss_model,brake_state_model);

OHWTBAnsys(main_dir,r,wind_speed,iter_Vw,FX,FY,M14,tip_loss_model,hub_loss_model,brake_state_model);
% Data2Ansys.m
OHWTBExcel(main_dir,r,wind_speed,r_hub,FX,FY,M14,tip_loss_model,hub_loss_model,brake_state_model);
end
end
