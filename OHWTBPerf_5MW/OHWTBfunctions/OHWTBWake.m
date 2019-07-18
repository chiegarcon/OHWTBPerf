%==========================================================================
% OHWTB v1.02 by CHIZHI                                       [OHWTBWake.m]
%--------------------------------------------------------------------------

function [a2,ap2] = OHWTBWake(B,c,r,sigma,F,delta,phi,...
    CL,CD,a1,use_drag_term,brake_state_model)

switch brake_state_model
    
    case(1) % Glauert's correction (1935)
        
        [a2,ap2] = Glauert(sigma,F,delta,phi,CL,CD,a1,use_drag_term);
        % see function Glauert
        
    case(2) % Oyel's correction (1983)
        
        [a2,ap2] = Oye(sigma,F,delta,phi,CL,CD,a1,use_drag_term);
        % see function Modified
        
    case(3) % Spera correction (1994)
        
        [a2,ap2] = Spera(sigma,F,delta,phi,CL,CD,a1,use_drag_term);
        % see function Advanced
        
    case(4) % Burton's  correction (2001)
        
        [a2,ap2] = Burton(sigma,F,delta,phi,CL,CD,a1,use_drag_term);
        % see function Advanced
        
    case(5) % Manwell correction (2002)
        
        [a2,ap2] = Manwell(sigma,F,delta,phi,CL,CD,a1,use_drag_term);
        % see function Wilson
        
    case(6) % Bossanyi's model (2004)
        
        [a2,ap2] = Bossanyi(sigma,F,delta,phi,CL,CD,a1,use_drag_term);
        
        
    case(7) % Buhl's model (2005)
        
        [a2,ap2] = Buhl(sigma,F,delta,phi,CL,CD,a1,use_drag_term);
        % see function Modified
        
    case(8) % Wilson's model (1974)
        
        [a2,ap2] = Wilson(B,c,r,F,delta,phi,CL,CD,a1,use_drag_term);
        
        
    case(9) % Shen's correction model (2005)
        
        [a2,ap2] = Shen(sigma,F,delta,phi,CL,CD,a1,use_drag_term);
        
    case(10) % New correction model (2018)
        
        [a2,ap2] = Chizhi(sigma,F,delta,phi,CL,CD,a1,use_drag_term);
        
    otherwise % Without correction
        
        [a2,ap2] = None(sigma,F,delta,phi,CL,CD,use_drag_term);
        % see function None
end

%--------------------------------------------------------------------------

function [a2,ap2] = Oye(sigma,F,delta,phi,CL,CD,a1,use_drag_term)
% see Table 2.9-1

CT = sigma*(cos(delta))^2*(1-a1)^2/(sin(phi))^2*...
    (CL*cos(phi)+use_drag_term*CD*sin(phi));

if CT <= 8/9*F
    
    %    a2 = 1/(4*F*sin(phi)*sin(phi)/(sigma*(CL*cos(phi)+use_drag_term*CD*sin(phi)))+1);
    a2 = (1-sqrt(1-CT/F))/2;
else
    
    y = (sqrt(1/36*(CT/F)^2-145*CT/(2187*F)+92/2187)+...
        CT/(6*F)-145/729)^(1/3);
    a2 = y-11/(81*y)+5/9;
    
end
if a2>1;        a2=1;  end
ap2 = 1/(4*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);

%--------------------------------------------------------------------------

function [a2,ap2] = Spera(sigma,F,delta,phi,CL,CD,a1,use_drag_term)
% see Table 2.9-1

CT = sigma*(cos(delta))^2*(1-a1)^2/(sin(phi))^2*...
    (CL*cos(phi)+use_drag_term*CD*sin(phi));

if CT <= 0.64*F
    
    %    a2 = 1/(4*F*sin(phi)*sin(phi)/(sigma*(CL*cos(phi)+use_drag_term*CD*sin(phi)))+1);
    a2 = (1-sqrt(1-CT/F))/2;
else
    
    ac = 0.2;
    K=4*F*sin(phi)^2/(sigma*(CL*cos(phi)+use_drag_term*CD*sin(phi)));
    a2 =0.5*(2+K*(1-2*ac)-sqrt((K*(1-2*ac)+2)^2+4*(K*ac^2-1)));
    
end
if a2>1;        a2=1;  end
ap2 = 1/(4*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);
%--------------------------------------------------------------------------

function [a2,ap2] = Burton(sigma,F,delta,phi,CL,CD,a1,use_drag_term)
% see Table 2.9-1

CT = sigma*(cos(delta))^2*(1-a1)^2/(sin(phi))^2*...
    (CL*cos(phi)+use_drag_term*CD*sin(phi));

if CT <= 8/9*F
    
    %    a2 = 1/(4*F*sin(phi)*sin(phi)/(sigma*(CL*cos(phi)+use_drag_term*CD*sin(phi)))+1);
    a2 = (1-sqrt(1-CT/F))/2;
else
    
    a2 =0.7192*CT/F-0.3061;
    
end
if a2>1;        a2=1;  end
ap2 = 1/(4*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);

%--------------------------------------------------------------------------

function [a2,ap2] = Manwell(sigma,F,delta,phi,CL,CD,a1,use_drag_term)
% see Table 2.9-1

CT = sigma*(cos(delta))^2*(1-a1)^2/(sin(phi))^2*...
    (CL*cos(phi)+use_drag_term*CD*sin(phi));

if CT <= 0.96*F
    
    %    a2 = 1/(4*F*sin(phi)*sin(phi)/(sigma*(CL*cos(phi)+use_drag_term*CD*sin(phi)))+1);
    a2 = (1-sqrt(1-CT/F))/2;
else
    
    a2 = ((.160000*F^2 - .731392*F + .642700*CT + .020449)^(1/2) + .143)/(F);
    
end
if a2>1;        a2=1;  end
ap2 = 1/(4*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);

%--------------------------------------------------------------------------

function [a2,ap2] = Bossanyi(sigma,F,delta,phi,CL,CD,a1,use_drag_term)
% see Table 2.9-1

CT = sigma*(cos(delta))^2*(1-a1)^2/(sin(phi))^2*...
    (CL*cos(phi)+use_drag_term*CD*sin(phi));

if CT <= 0.96*F
    
    %    a2 = 1/(4*F*sin(phi)*sin(phi)/(sigma*(CL*cos(phi)+use_drag_term*CD*sin(phi)))+1);
    a2 = (1-sqrt(1-CT/F))/2;
else
    
    a2 = (50*((31600*CT - 15239*F)/(10000*F))^(1/2))/79 - 61/158;
    
end
if a2>1;        a2=1;  end
ap2 = 1/(4*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);


%--------------------------------------------------------------------------

function [a2,ap2] = Glauert(sigma,F,delta,phi,CL,CD,a1,use_drag_term)
% see Table 2.9-1

CT = sigma*(cos(delta))^2*(1-a1)^2/(sin(phi))^2*...
    (CL*cos(phi)+use_drag_term*CD*sin(phi));

if CT <= 0.96*F
    
    %    a2 = 1/(4*F*sin(phi)*sin(phi)/(sigma*(CL*cos(phi)+use_drag_term*CD*sin(phi)))+1);
    a2 = (1-sqrt(1-CT/F))/2;
else
    
    a2 = 0.1427+0.3213/F*sqrt(-F^2*5.3360+6.2240*CT*F);
    
end
if a2>1;        a2=1;  end
ap2 = 1/(4*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);


%--------------------------------------------------------------------------

function [a2,ap2] = Buhl(sigma,F,delta,phi,CL,CD,a1,use_drag_term)
% see Table 2.9-1

CT = sigma*(cos(delta))^2*(1-a1)^2/(sin(phi))^2*...
    (CL*cos(phi)+use_drag_term*CD*sin(phi));

if CT <= 0.96*F
    
    %    a2 = 1/(4*F*sin(phi)*sin(phi)/(sigma*(CL*cos(phi)+use_drag_term*CD*sin(phi)))+1);
    a2 = (1-sqrt(1-CT/F))/2;
else
    
    a2 = ((18*F-20-3*sqrt(CT*(50-36*F)+12*F*(3*F-4)))/(36*F-50));
    
end

if a2>1;        a2=1;  end

ap2 = 1/(4*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);

%--------------------------------------------------------------------------

function [a2,ap2] = Wilson(B,c,r,F,delta,phi,CL,CD,a1,use_drag_term)
% see Table 2.9-1

sigma = B*c/(pi*r*cos(delta));
CT = sigma*(cos(delta))^2*(1-a1)^2/(sin(phi))^2*...
    (CL*cos(phi)+use_drag_term*CD*sin(phi))/2;

if CT <= 1.6*F*(1-0.4*F)
    
    a2 = -((1 - CT)^(1/2) - 1)/(2*F);
    
else
    
    
    Sw = sigma*(cos(delta))^2*(CL*cos(phi)+use_drag_term*CD*sin(phi))/...
        (8*(sin(phi))^2);
    a2 = (2*Sw+F-sqrt(F^2+4*Sw*F*(1-F)))/(2*(Sw+F^2));
    
end
if a2>1;        a2=1;  end
ap2 = 1/(8*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);

%--------------------------------------------------------------------------

function [a2,ap2] = Shen(sigma,F,delta,phi,CL,CD,a1,use_drag_term)
% see Table 2.9-1

CT = sigma*(cos(delta))^2*(1-a1)^2/(sin(phi))^2*...
    (CL*cos(phi)+use_drag_term*CD*sin(phi));

if CT <= 4/9*(3-F)*F
    
    a2 = -((1 - CT)^(1/2) - 1)/(2*F);
    
else
    
    
    a2 = (- 4*F^2*(1/3)^2 + CT)/(4*F - 8*F*1/3);
    
end
if a2>1;        a2=1;  end

ap2=1/(4*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);

%--------------------------------------------------------------------------
function [a2,ap2] = Chizhi(sigma,F,delta,phi,CL,CD,a1,use_drag_term)
% see Table 2.9-1

CT = sigma*(cos(delta))^2*(1-a1)^2/(sin(phi))^2*...
    (CL*cos(phi)+use_drag_term*CD*sin(phi));

if CT <= 1.6*(1-0.4*F)*F
    
    a2 = -((1 - CT)^(1/2) - 1)/(2*F);
    
else
    
    m0 = (2-4*F+4*F^2*(0.4)*(2-0.4))/(1-0.4)^2;
    m1 = (-4*0.4+4*F*(1+0.4^2)-8*F^2*0.4)/(1-0.4)^2;
    m2 = (2*0.4^2-4*F*0.4^2+4*F^2*0.4^2)/(1-0.4)^2;
    
    a2= -(m1 - (m1^2 + 4*CT*m0 - 4*m0*m2)^(1/2))/(2*m0);
    
end
if a2>1;        a2=1;  end

ap2=1/(4*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);

%--------------------------------------------------------------------------

function [a2,ap2] = None(sigma,F,delta,phi,CL,CD,use_drag_term)

a2 = 1/(4*F*(sin(phi))^2/(sigma*(cos(delta))^2*(CL*cos(phi)+...
    use_drag_term*CD*sin(phi)))+1);

ap2 = 1/(4*F*sin(phi)*cos(phi)/(sigma*(CL*sin(phi)-...
    use_drag_term*CD*cos(phi)))-1);
if a2>1;        a2=1;  end

%==========================================================================
