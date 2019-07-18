%==========================================================================
% OHWTB v1.02 by CHIZHI                                    [OHWTBResult.m]
%--------------------------------------------------------------------------

function [P_avg,AEP] = OHWTBResult(n,P,wind_speed,thrust,torque,power,...
        power_coefficient,max_flap_at_hub,Vstep,V_avg,main_dir,tip_loss_model,hub_loss_model,brake_state_model)

% Inputs:
% n = total number of wind data = iter_Vw in the main program
% P = power, kW
% V = wind speed range from cut-in to cut-out wind speed, m/s
% Vstep = increment of wind speed, m/s
% V_avg = average wind speed at site, m/s
%
% Outputs:
% P_avg = average power, kW
% AEP = annual energy production, kWh

% Rayleigh distribution

PDF = zeros(1,n);
P_avg = zeros(1,n);

for i = 1 : n
    
%   Probability Density Function (PDF) 
    PDF(i) = 2/wind_speed(i)*pi/4*(wind_speed(i)/V_avg)^2*exp(-pi/4*(wind_speed(i)/V_avg)^2);        
                                                             % Eq. (2.6-15)
%   Average power at each wind speed, kW
    if P(i) < 0
        
        P_avg(i) = 0;
        
    else

        P_avg(i) = P(i)*PDF(i)*Vstep;
        
    end
    
end

% Average power, kW
P_avg = sum(P_avg(~isnan(P_avg)));

% Annual energy production, kWh/yr
AEP = P_avg*8640;
Perf_dir = [main_dir,'Results\OHWTBPerf'];

if ~exist(Perf_dir, 'dir')
    % Folder does not exist so create it.
    mkdir(Perf_dir);
end

fprintf('Average Power = %4.2f kW\n',P_avg)
fprintf('Annual Energy Production (AEP) = %7.0f kWh\n',AEP)

wtperf_dir = [Perf_dir,'\'];
wtperf_file = [wtperf_dir,'OHWTBPerf_',num2str(tip_loss_model),'_',num2str(hub_loss_model),'_',num2str(brake_state_model),'.dat'];
fid_wtperf = fopen(wtperf_file,'w');

fprintf(fid_wtperf,'Average Power = %4.2f kW\n',P_avg);
fprintf(fid_wtperf,'Annual Energy Production (AEP) = %7.0f kWh\n',AEP);
fprintf(fid_wtperf,'===============================================\n');
fprintf(fid_wtperf,'Vw	Thrust	Torque	Power	CP	FBmax \n');
fprintf(fid_wtperf,'m/s	kN	kN-m	kW	-	(kN-m)\n');
fprintf(fid_wtperf,'-----------------------------------------------\n');

for i = 1 : length(wind_speed)
    
    fprintf(fid_wtperf,'%6.3f\t%6.3f\t%6.3f\t%6.3f\t%6.4f\t%6.3f\n',...
        wind_speed(i),thrust(i),torque(i),power(i),...
        power_coefficient(i),max_flap_at_hub(i));

end

fprintf(fid_wtperf,'===============================================\n');
end

%==========================================================================
