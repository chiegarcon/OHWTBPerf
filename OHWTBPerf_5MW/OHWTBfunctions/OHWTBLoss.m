%==========================================================================
% OHWTB v1.02 by CHIZHI                                    [OHWTBLoss.m]
%--------------------------------------------------------------------------

function F = OHWTBLoss(B,R,r,r_hub,phi,lamda_r,tip_loss_model,hub_loss_model)

switch tip_loss_model
    
    case(1) % Prandtl's tip loss model
        
        F_tip = TipPrandtl(B,R,r,phi);               % see function Prandtl

    case(2) % Xu's tip loss model
        
        F_tip = TipXu(B,R,r,phi);                    % see function Xu
        
    case(3) % Shen's tip loss model
        
        F_tip = TipShen(B,R,r,phi,lamda_r);          % see function Shen
        
    case(4) % Shen's tip loss model
        
        F_tip = TipShen(B,R,r,phi,lamda_r);          % see function Shen  
        
    case(5) % Golds tip loss model
        
        F_tip = TipGold(B,R,r,phi);
        
    case(0) % Without tip loss correction
        
        F_tip = 1;
        
end

switch hub_loss_model
    
    case(1) % Prandtl's hup loss model
        
        F_hub = HubPrandtl(B,r,r_hub,phi);           % HubLossPrandtl.m
        
    case(2)  % Xu's hub loss model
        
        F_hub = HubXu(B,r,r_hub,phi);               % see function Xu        
        
    case(3) % Shen's hub loss model
        
        F_hub = HubShen(B,r,r_hub,phi,lamda_r);
    
    case(4) % Prandtl's hup loss model
        
        F_hub = HubPrandtl(B,r,r_hub,phi);           % HubLossPrandtl.m
        
      case(5) % Gold's tip loss model
        
        F_hub = HubGold(B,r,r_hub,phi);      
        
    case(0) % Without hub loss correction
        
        F_hub = 1;
        
end

F = F_tip*F_hub;

%--------------------------------------------------------------------------

function F_tip = TipPrandtl(B,R,r,phi)

% Prandtl's tip loss correction
f_tip = B*(R-r)/(2*r*sin(phi));                               % Eq. (2.4-3)

F_tip = 2/pi*acos(exp(-f_tip));                           % Eq. (2.4-2)

%--------------------------------------------------------------------------

function F_tip = TipXu(B,R,r,phi)

% Xu's tip loss correction

if r/R < 0.7
    
    f_tip_r07 = B*(1-0.7)/(2*0.7*sin(phi));           % Eq. (2.4-7)
    
    if abs(f_tip_r07) < 7
        
        ftip_r07 = 2/pi*acos(exp(-f_tip_r07));
        
    else
        
        ftip_r07 = 1;
        
    end
    
    F_tip = 1-r*(1-ftip_r07)/(0.7*R);                 % Eq. (2.4-6)
    
else
    
    F_tip_Prandtl = TipPrandtl(B,R,r,phi);      % see function Prandtl
    
    F_tip = 0.5*(F_tip_Prandtl^0.85+0.5);             % Eq. (2.4-6)
    
end

%--------------------------------------------------------------------------

function F_tip = TipShen(B,R,r,phi,lamda_r)

f_tip = B*(R-r)/(2*r*sin(phi));
% Shen's tip loss correction

g = exp(-0.125*(B*lamda_r-21))+0.1;                          % Eq. (2.4-10)

F_tip = 2/pi*acos(exp(-g*f_tip));                     % Eq. (2.4-9)

%--------------------------------------------------------------------------

function F_tip = TipGold(B,R,r,phi)

% Prandtl's tip loss correction
f_tip = B/(2*r/R*tan(phi))-0.5;                % Eq. (2.4-3)

F_tip = 2/pi*acos(cosh(r/R*f_tip)/cosh(f_tip));                           % Eq. (2.4-2)


%==========================================================================


function F_hub = HubPrandtl(B,r,r_hub,phi)

f_hub = B*(r-r_hub)/(2*r_hub*sin(phi));                       % Eq. (2.4-5)

F_hub = 2/pi*acos(exp(-f_hub));                           % Eq. (2.4-4)

%--------------------------------------------------------------------------

function F_hub = HubXu(B,r,r_hub,phi)

% Xu's tip loss correction

if r_hub/r < 0.7
    
    f_hub_r07 = B*(1-0.7)/(2*0.7*sin(phi));           % Eq. (2.4-7)
    
    if abs(f_hub_r07) < 7
        
        fhub_r07 = 2/pi*acos(exp(-f_hub_r07));
        
    else
        
        fhub_r07 = 1;
        
    end
    
    F_hub = 1-r_hub*(1-fhub_r07)/(0.7*r);                 % Eq. (2.4-6)
    
else
    
    F_hub_Prandtl = HubPrandtl(B,r,r_hub,phi);      % see function Prandtl
    
    F_hub = 0.5*(F_hub_Prandtl^0.85+0.5);             % Eq. (2.4-6)
    
end

%--------------------------------------------------------------------------
function F_hub = HubShen(B,r,r_hub,phi,lamda_r)

f_hub = B*(r-r_hub)/(2*r_hub*sin(phi));
% Shen's tip loss correction
% see function Prandtl
g = exp(-0.125*(B*lamda_r-21))+0.1;                          % Eq. (2.4-10)

F_hub = 2/pi*acos(exp(-g*f_hub));                     % Eq. (2.4-9)

%--------------------------------------------------------------------------
function F_hub = HubGold(B,r,r_hub,phi)

% Prandtl's tip loss correction
f_hub = B/(2*r_hub/r*tan(phi))-0.5;                % Eq. (2.4-3)

F_hub = 2/pi*acos(cosh(r_hub/r*f_hub)/cosh(f_hub)); 

%==========================================================================



















