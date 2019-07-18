% =========================================================================
% OHWTB v1.02 by CHI                       [Plot corrections of comparions]
% -------------------------------------------------------------------------

clear
close all
F1=1;
bema=0:0.025:1;
bema2=0.4:0.025:1;
ct1=zeros(1);
ct2=zeros(1);
ct3=zeros(1);
ct4=zeros(1);
for i=1:length(bema)
    %
    ct1(i)=4*bema(i)*(1-bema(i));
    ct3(i)=4*bema(i)*(1-bema(i))*F1;
    
end

for j=1:length(bema2)
    
    
    ct2(j)=0.889-0.444*bema(j+length(bema)-length(bema2))+1.556*bema(j+length(bema)-length(bema2))^2;
    
    ct4(j)=0.889-0.444*bema(j+length(bema)-length(bema2))*F1+1.556*bema(j+length(bema)-length(bema2))^2*F1^2;
    
end

% Experimental data are digitized (See also Table 3.2-1) from
% Wilson, Lissaman and Walker (1976, p.49)

% NACA TN-221 (4-Blade)
a_naca_tn_221_4b = [0.268 0.525 0.667 0.704];
ct_naca_tn_221_4b = [0.836 1.310 1.590 1.680];

% NACA TN-221 (2-Blade)
a_naca_tn_221_2b = [0.337 0.679 0.737 0.789 0.847 0.876 0.897];
ct_naca_tn_221_2b = [0.951 1.360 1.470 1.460 1.560 1.500 1.460];

% R&M 885-uv
a_rm_885_uv = [0.455 0.752 0.793 0.805 0.826 0.846 0.900 0.918];
ct_rm_885_uv = [1.310 1.570 1.570 1.650 1.650 1.650 1.680 1.700];

% R&M 885-cv
a_rm_885_cv = [0.282 0.538 0.697 0.734];
ct_rm_885_cv = [0.826 1.260 1.360 1.410];


figure
hold on
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
set (gcf,'Position',[100 100 600 360], 'color','w')

plot(bema,ct1,'r-','LineWidth',2)
plot(bema2,ct2,'k-','LineWidth',2)
plot(bema,ct3,'c--','LineWidth',2)
plot(bema2,ct4,'b-.','LineWidth',2)
plot(a_naca_tn_221_4b,ct_naca_tn_221_4b,'ok');       % NACA TN-221 (4-Blade)
plot(a_naca_tn_221_2b,ct_naca_tn_221_2b,'ok','MarkerFaceColor','k'); % NACA TN-221 (4-Blade)
plot(a_rm_885_uv,ct_rm_885_uv,'^k');                            % R&M 885-uv
plot(a_rm_885_cv,ct_rm_885_cv,'^k','MarkerFaceColor','k');      % R&M 855-cv


legend({'No correction','Glauert empirical relations','No correction (F=0.75)','Glauert empirical relations (F=0.75)',...
    'NACA TN-221 (4-Blade)',...
    'NACA TN-221 (2-Blade)',...
    'R&M 885-uv',...
    'R&M 885-cv'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')

xlabel({'Axial induction factor, a'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Thrust coefficient, C_t'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([0 1 0 2])
legend boxoff
box on

ct41(i)=zeros(1);
ct42(i)=zeros(1);
ct43(i)=zeros(1);
ct44(i)=zeros(1);
ct45(i)=zeros(1);
ct46(i)=zeros(1);
ct47(i)=zeros(1);
ct48(i)=zeros(1);
ct49(i)=zeros(1);
ct50(i)=zeros(1);


for i=1:length(bema)
    %
    if bema(i)<=1/3 % Glauert's  equation
        
        ct41(i)=4*bema(i)*F1*(1-bema(i));
        
    else
        
        ct41(i)=4*bema(i)*(1-0.25*(5-3*bema(i))*bema(i))*F1;
        
    end
    
    if bema(i)<=0.36 % Burton's  correction (2001)
        
        ct48(i)=4*bema(i)*F1*(1-bema(i)*F1);
        
    else
        
        
        ct48(i) = (1.6-4*(sqrt(1.6)-1)*(1-bema(i)))*F1;
        
    end
    
    if bema(i)<=1/3 % Burton's  correction (2001)
        
        ct43(i)=4*bema(i)*F1*(1-bema(i)*F1);
        
    else
        
        
        ct43(i) = (1.816-4*(sqrt(1.816)-1)*(1-bema(i)))*F1;
        
    end
    
    if bema(i)<=0.2 %Spera correction
        
        ct42(i)=4*bema(i)*(1-bema(i))*F1;
        
    else
        
        ct42(i)=4*(0.2*0.2+(1-2*0.2)*bema(i))*F1;
        
    end
    
    if bema(i)<=0.4 % Manwell correction (2002)
        
        ct44(i)=4*bema(i)*(1-bema(i))*F1;
        
    else
        
        ct44(i)=0.96*F1+F1*(bema(i)-0.4)*((bema(i)+0.4)*F1-0.286)/0.6427;
        
    end
    
    if bema(i)<=0.4 % Bal's model (2004)
        
        ct45(i)=4*bema(i)*(1-bema(i))*F1;
        
    else
        
        ct45(i)=0.6*F1+0.61*bema(i)*F1+0.79*bema(i)^2*F1;
        
    end
    
    if bema(i)<=0.4 % Simple Buhl's model (2004)
        
        ct46(i)=4*bema(i)*(1-bema(i))*F1;
        
    else
        
        ct46(i)=0.889*F1-0.444*bema(i)*F1+1.556*bema(i)^2*F1;
        
    end
    
    if bema(i)<=0.4
        
        ct47(i)=4*bema(i)*(1-bema(i))*F1;
        
    else
        
        m0 = 50/9-4*F1;
        m1 = 4*F1-40/9;
        m2 = 8/9;
        
        ct47(i) = m0*bema(i)^2+m1*bema(i)+m2;
        
    end
    
    if bema(i)<=1/3
        
        ct49(i)=4*bema(i)*(1-bema(i)*F1)*F1;
        
    else
        
        
        ct49(i) = 4*(1/3*1/3*F1*F1+(1-2*1/3*F1)*bema(i)*F1);
        
    end
    
    if bema(i)<=0.4
        
        ct50(i)=4*bema(i)*(1-bema(i)*F1)*F1;
        
    else
        
        m0 = (2-4*F1+4*F1^2*(0.4)*(2-0.4))/(1-0.4)^2;
        m1 = (-4*0.4+4*F1*(1+0.4^2)-8*F1^2*0.4)/(1-0.4)^2;
        m2 = (2*0.4^2-4*F1*0.4^2+4*F1^2*0.4^2)/(1-0.4)^2;
        
        
        
        ct50(i) = m0*bema(i)^2+m1*bema(i)+m2;
        
    end
    
    
end

figure
hold on
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
set (gcf,'Position',[100 100 800 400], 'color','w')


plot(bema,ct3,'k-','LineWidth',2)

plot(bema,ct41,'r-o','LineWidth',2)
plot(bema,ct42,'k-.x','LineWidth',2)
plot(bema,ct43,'g-.h','LineWidth',2)
plot(bema,ct44,'m--d','LineWidth',2)
plot(bema,ct45,'b--p','LineWidth',2)
plot(bema,ct46,'g--^','LineWidth',2)
plot(bema,ct47,'r:s','LineWidth',2)
plot(bema,ct48,'m:*','LineWidth',2)
plot(bema,ct49,'b-.+','LineWidth',2)
plot(bema,ct50,'y-.x','LineWidth',2)

plot(a_naca_tn_221_4b,ct_naca_tn_221_4b,'ok');       % NACA TN-221 (4-Blade)
plot(a_naca_tn_221_2b,ct_naca_tn_221_2b,'ok','MarkerFaceColor','k'); % NACA TN-221 (4-Blade)
plot(a_rm_885_uv,ct_rm_885_uv,'^k');                            % R&M 885-uv
plot(a_rm_885_cv,ct_rm_885_cv,'^k','MarkerFaceColor','k');      % R&M 855-cv


legend({'No correction','Glauert''s correction','Oye''s correction','Spera''s correction','Burton''s correction',...
    'Manwell''s correction','Bossanyi''s correction',...
    'Buhl''s correction','Wilson''s correction','Shen''s correction','Chizhi''correction'...
    'NACA TN-221 (4-Blade)',...
    'NACA TN-221 (2-Blade)',...
    'R&M 885-uv',...
    'R&M 885-cv'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')

xlabel({'Axial induction factor, a'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Thrust coefficient, C_t'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([0 1 0 2])
legend boxoff
box on
