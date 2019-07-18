%==========================================================================
% OHWTBPerf 1.02 by CHIZHI                              [Power comparision]
%--------------------------------------------------------------------------

clear
close all

addpath(genpath([fullfile(cd),'\OHWTBfunctions'])); 
%Add directories to search path

main_dir = which('OHWTBMain.m');
main_dir = main_dir(1:end-length('OHWTBMain.m'));

blade_dir1 = [main_dir,'Results\OHWTBPerf\'];

blade_dir = [main_dir,'BladeData\ExistData\'];
bfname = [blade_dir,'speed2power.dat'];

topology = OHWTBData(bfname,2,3,0);
wind_speed = topology(:,1);
power = topology(:,2);


for tip_loss_model=0:5
    
    hub_loss_model=tip_loss_model;
    
    figure
    hold on
    set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
    set (gcf,'Position',[100 100 600 360], 'color','w')
    
    plot(wind_speed,power,'k^','LineWidth',1)
    
    for brake_state_model=0:10       
      
        bfname1 = [blade_dir1,'OHWTBPerf_',num2str(tip_loss_model),'_',num2str(hub_loss_model),'_',num2str(brake_state_model),'.dat'];
        
        topology1 = OHWTBData(bfname1,6,6,0);
        
        wind_speed1 = topology1(:,1);
        
        power1(brake_state_model+1,:) = topology1(:,4);
              
        r2(brake_state_model+1,hub_loss_model+1)=COD(power,topology1(:,4))*100;
        
        
    end
    
    eval(sprintf('Epower%d = [power1];',hub_loss_model));
    
    plot(wind_speed1,power1,'-','LineWidth',1)
    
    legend({'Experimental data','No correction','Glauert''s correction','Oye''s correction','Spera''s correction','Burton''s correction',...
        'Manwell''s correction','Bossanyi''s correction','Buhl''s correction','Wilson''s correction','Shen''s correction','Chizhi''s correction',...
        },'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','southeast')
    
    xlabel({'Wind speed [m/s]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
    ylabel({'Power [kW]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
    axis([0 25 0 6000])
    legend boxoff
    box on
    
end
r2=round(r2,4);
function R2=COD(y,f)
%     y=reshape(y,1,numel(y));
%     f=reshape(f,1,numel(f));
    %This calculates the coefficient of determination
    ymean=mean(y); % 
    SStot=0;
    SSerr=0;
    for i=1:length(y) %loop through each point
        SStot=SStot+(y(i)-ymean)^2;
        SSerr=SSerr+(y(i)-f(i))^2;
    end
    R2=1-SSerr/SStot;
end %End function...



