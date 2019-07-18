%==========================================================================
% OHWTB v1.02 by CHIZHI                                      [OHWTBForce.m]
%--------------------------------------------------------------------------

function [L,D,M14,FX,FY,MZ] = OHWTBForce(rho,c,Vrel,CL,CD,CM14,phi,...
    iter_Vw,n_seg,dr,main_dir,tip_loss_model,hub_loss_model,brake_state_model)

% Lift and drag forces, N, and pitching moment, N-m
[dL,dD,dM14,L,D,M14] = AerodynamicLoad(rho,c,Vrel,CL,CD,CM14,iter_Vw,...
    n_seg,dr);
                                             % see function AerodynamicLoad
% Global forces, FX, FY and FZ, N
[FX,FY,dFX,dFY] = XYZForce(dL,dD,phi,iter_Vw,n_seg);
                                                    % see function XYZForce
% Global flap and edge bending moment, N-m
[MZ] = XYZMoment(dr,n_seg,iter_Vw,rho,c,Vrel,CM14);


Forces_dir = [main_dir,'Results\OHWTBForces\'];

if ~exist(Forces_dir, 'dir')
    % Folder does not exist so create it.
    mkdir(Forces_dir);
end

% Edgewist force, N
rsfname = [Forces_dir,'FX_',num2str(tip_loss_model),'_',num2str(hub_loss_model),'_',num2str(brake_state_model),'.dat'];
save(rsfname,'FX','-ASCII','-tabs')

 % Flapwise force, N
rsfname = [Forces_dir,'FY_',num2str(tip_loss_model),'_',num2str(hub_loss_model),'_',num2str(brake_state_model),'.dat'];
save(rsfname,'FY','-ASCII','-tabs')

 % Pitching moment, N-m
rsfname = [Forces_dir,'M14_',num2str(tip_loss_model),'_',num2str(hub_loss_model),'_',num2str(brake_state_model),'.dat'];
save(rsfname,'M14','-ASCII','-tabs')

 % Twisting moment, N-m
rsfname = [Forces_dir,'MZ_',num2str(tip_loss_model),'_',num2str(hub_loss_model),'_',num2str(brake_state_model),'.dat'];
save(rsfname,'MZ','-ASCII','-tabs')
                                                   % see function XYZMoment
                                                   
%--------------------------------------------------------------------------

function [dL,dD,dM14,L,D,M14] = AerodynamicLoad(rho,c,Vrel,CL,CD,CM14,...
    iter_Vw,n_seg,dr)

% Calculation of lift and drag forces

dL = zeros(n_seg,iter_Vw);
dD = zeros(n_seg,iter_Vw);
dM14 = zeros(n_seg,iter_Vw);
L = zeros(n_seg,iter_Vw);
D = zeros(n_seg,iter_Vw);
M14 = zeros(n_seg,iter_Vw);

for k = 1 : iter_Vw % Wind speed loop

    for j = 1 : n_seg % Segment loop
        
    
            
%           Lift force produced by a differential blade element, N
            dL(j,k) = 0.5*rho*c(j)*Vrel(j,k)^2*CL(j,k)*dr(j);
                                                              % Eq. (2.8-1)
            L(j,k) = L(j,k)+dL(j,k);  
            
%           Drag force produced by a differential blade element, N
            dD(j,k) = 0.5*rho*c(j)*Vrel(j,k)^2*CD(j,k)*dr(j);  
                                                              % Eq. (2.8-2)
            D(j,k) = D(j,k)+dD(j,k);
            
%           Pitching moment produced by a differential blade element, N-m            
            dM14(j,k) = 0.5*rho*c(j)^2*Vrel(j,k)^2*CM14(j,k)*dr(j); 
                                                              % Eq. (2.8-4)
            M14(j,k) = M14(j,k)+dM14(j,k); 
              
        
    end % Segment loop
        
end % Wind speed loop


%--------------------------------------------------------------------------
 
function [FX,FY,dFX,dFY] = XYZForce(dL,dD,phi,iter_Vw,n_seg)

% Calculation of FX, FY and FZ in global coordinate system

dFX = zeros(n_seg,iter_Vw);
dFY = zeros(n_seg,iter_Vw);

FX = zeros(n_seg,iter_Vw);
FY = zeros(n_seg,iter_Vw);




for k = 1 : iter_Vw % Wind speed loop

    for j = 1 : n_seg % Segment loop
        

            
%           X-component (Leadwise Force), N
            dFX(j,k) = -dL(j,k)*sin(phi(j,k))+...
                dD(j,k)*cos(phi(j,k));                    % Eq. (2.8-5)
            FX(j,k) = FX(j,k)+dFX(j,k);
            
%           Y-compoment (Flapwise Force), N 
            dFY(j,k) = dL(j,k)*cos(phi(j,k))+...
                dD(j,k)*sin(phi(j,k));                    % Eq. (2.8-6)
            FY(j,k) = FY(j,k)+dFY(j,k);
            
            

        
    end % {Segment loop}
    
end % {Wind speed loop}


% %--------------------------------------------------------------------------
% 
function [MZ] = XYZMoment(dr,n_seg,iter_Vw,rho,c,Vrel,CM14)

% Calculate flap and edge bending moments and twisting moment

n_node = n_seg+1; 

MZ = zeros(n_seg,iter_Vw);

for k = 1 : iter_Vw % Wind speed loop

    for j = 1 : n_seg % Node loop
        

        dMZ = 0;
        

            for j_node = j : n_node-1 % Sum loop

               
%               Twisting moment, N-m                
                dMZ = dMZ+(-0.5*rho*c(j_node)^2*Vrel(j_node,k)^2*...
                    CM14(j_node,k)*dr(j_node));  % Eq. (2.8-4)
                
            end % {Sum loop}

       
        MZ(j,k) = MZ(j,k)+dMZ;

    end % {Segment loop}
    
end % (Wind speed loop}
%==========================================================================
