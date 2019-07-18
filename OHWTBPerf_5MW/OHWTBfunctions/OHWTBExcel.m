% =========================================================================
% OHWTBPerf 1.02 BY CHIZHI                                   [OHWTBExcel.m]
% -------------------------------------------------------------------------

function [] = OHWTBExcel(main_dir,r,wind_speed,r_hub,FX_data,...
    FY_data,M14_data,tip_loss_model,hub_loss_model,brake_state_model)


xlsfname = [main_dir,'Results\AnsysLoad\Loads_',num2str(tip_loss_model),'_',num2str(hub_loss_model),'_',num2str(brake_state_model),'\ExcelLoad.xlsx'];
r_element = r-r_hub;
n_save = 4;

deletename=[main_dir,'Results\AnsysLoad\Loads_',num2str(tip_loss_model),'_',num2str(hub_loss_model),'_',num2str(brake_state_model)];

delete([deletename,'*.xlsx']);

WaitSave = waitbar(0,'',...
    'Name','OHWTBMain V1.02',...
    'Unit','normalized',...
    'Position',[0.360 0.500 0.285 0.080]);

warning('off', 'MATLAB:xlswrite:AddSheet');

i_save = 1;
save_done = (i_save-1)/(n_save-1);
waitbar(save_done,WaitSave,'Please wait ...')
xlswrite(xlsfname,'{r}','FX','A1');
xlswrite(xlsfname,wind_speed,'FX','B1');
xlswrite(xlsfname,r_element,'FX','A2');
xlswrite(xlsfname,FX_data,'FX','B2');
save_done = (i_save-1)/(n_save-1);
waitbar(save_done,WaitSave,'Saving results to Excel')

i_save = 2;
xlswrite(xlsfname,'{r}','FY','A1');
xlswrite(xlsfname,wind_speed,'FY','B1');
xlswrite(xlsfname,r_element,'FY','A2');
xlswrite(xlsfname,FY_data,'FY','B2');
save_done = (i_save-1)/(n_save-1);
waitbar(save_done,WaitSave,'Saving results to Excel')

i_save = 3;
xlswrite(xlsfname,'{r}','M14','A1');
xlswrite(xlsfname,wind_speed,'M14','B1');
xlswrite(xlsfname,r_element,'M14','A2');
xlswrite(xlsfname,M14_data,'M14','B2');
save_done = (i_save-1)/(n_save-1);
waitbar(save_done,WaitSave,'Saving results to Excel')

close(WaitSave)

