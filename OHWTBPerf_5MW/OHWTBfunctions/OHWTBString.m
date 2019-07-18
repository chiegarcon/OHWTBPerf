%==========================================================================
% OHWTB v1.02 by CHIZHI                                    [OHWTBString.m]
%--------------------------------------------------------------------------
function timestr = OHWTBString(sec)

% Convert a time measurement from seconds into a human readable string.

% Convert seconds to other units
d = floor(sec/86400); % Days
sec = sec - d*86400;
h = floor(sec/3600); % Hours
sec = sec - h*3600;
m = floor(sec/60); % Minutes
sec = sec - m*60;
s = floor(sec); % Seconds

% Create time string
if d > 0
    
    if d > 9
        
        timestr = sprintf('%d day',d);
        
    else
        
        timestr = sprintf('%d day, %d hr',d,h);
        
    end
    
elseif h > 0
    
    if h > 9
        
        timestr = sprintf('%d hr',h);
        
    else
        
        timestr = sprintf('%d hr, %d min',h,m);
        
    end
    
elseif m > 0
    
    if m > 9
        
        timestr = sprintf('%d min',m);
        
    else
        
        timestr = sprintf('%d min, %d sec',m,s);
        
    end
    
else
    
    timestr = sprintf('%d sec',s);
    
end