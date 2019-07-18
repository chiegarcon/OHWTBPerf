%==========================================================================
% OHWTBPerf 1.02                                      [OHWTBChange.m]
%--------------------------------------------------------------------------

function [a1,ap1,converge] = OHWTBChange(a1,ap1,a2,ap2,tolerance)

if abs(a2-a1) <= tolerance && abs(ap2-ap1) <= tolerance
    
    converge = false;
    
else
    
    a1 = (a1+a2)/2;                                       % Eq. (2.6-5)
    ap1 = (ap1+ap2)/2;                                    % Eq. (2.6-6)

    converge = true;
    
end


