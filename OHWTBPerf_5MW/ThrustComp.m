% =========================================================================
% OHWTB v1.02 by CHI                                     [Plot corrections]
% -------------------------------------------------------------------------

clear
close all
clc
for brake_state_model=0:11
    
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
    
    plot(a_naca_tn_221_4b,ct_naca_tn_221_4b,'ok');       % NACA TN-221 (4-Blade)
    plot(a_naca_tn_221_2b,ct_naca_tn_221_2b,'ok','MarkerFaceColor','k'); % NACA TN-221 (4-Blade)
    plot(a_rm_885_uv,ct_rm_885_uv,'^k');                            % R&M 885-uv
    plot(a_rm_885_cv,ct_rm_885_cv,'^k','MarkerFaceColor','k');      % R&M 855-cv
    
    
    
    
    if (brake_state_model) == 1  % Glauert's correction (1935)
        % [ac = 1/3]
        % [ac = 0.4]
        for fg = 0.1 : 0.1 : 1
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1)*fg;                        % Momentum theory [ag < 0.4]
            
            plot(ag1,ctfg1,'r:','LineWidth',1);
            ag2 = 0 : 0.01 : 0.4;
            ctfg2 = 4*fg*ag2.*(1-ag2);
            
            ag3 = 0.4 : 0.01 : 1;
            ctfg3 = fg*(0.889-0.444*ag3+1.556*ag3.^2);
            
            ag4=[ag2,ag3];
            ctfg4=[ctfg2,ctfg3];
            plot(ag4,ctfg4,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('Glauert''s correction (1935)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method',...
            'Simple Buhl''s correction'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on
        
        
       elseif (brake_state_model) == 2  % Oyel's correction (1983)
           
         for fg = 0.1 : 0.1 : 1
            
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1)*fg;                        % Momentum theory [ag < 0.4]
            
            plot(ag1,ctfg1,'r:','LineWidth',1);
            
            ag2 = 0 : 0.01 : 0.33;
            ctfg2 = 4*fg*ag2.*(1-ag2);
            
            ag3 = 0.34 : 0.01 : 1;
            ctfg3 = 4*ag3*fg.*(1-1/4*(5-3*ag3).*ag3);
            
            ag4=[ag2,ag3];
            ctfg4=[ctfg2,ctfg3];
            plot(ag4,ctfg4,'b-','LineWidth',2)
        end
        
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('Oye''s correction (1983)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method',...
            'Glauert''s correction'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on

    elseif (brake_state_model) == 3  % Spera correction (1994)
        % [ac = 0.2]
        for fg = 0.1 : 0.1 : 1
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1)*fg;         % Momentum theory [ag < 0.2]
            
            plot(ag1,ctfg1,'r:','LineWidth',1);
            ag2 = 0 : 0.01 : 0.2;
            ctfg2 = 4*fg*ag2.*(1-ag2);
            
            ag3 = 0.2 : 0.01 : 1;
            ctfg3 = 4*fg*(0.2^2+(1-2*0.2)*ag3);
            
            ag4=[ag2,ag3];
            ctfg4=[ctfg2,ctfg3];
            plot(ag4,ctfg4,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('Spera''s correction (1994)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method',...
            'Spera''s correction'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on
        
        
    elseif (brake_state_model) == 4  % Burton's  correction (2001)
        % [ac = 1/3]
        for fg = 0.1 : 0.1 : 1
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1)*fg;                        % Momentum theory [ag < 1/3]
            
            plot(ag1,ctfg1,'r:','LineWidth',1);
            ag2 = 0 : 0.01 : 0.33;
            ctfg2 = 4*fg*ag2.*(1-ag2);
            
            ag3 = 0.33 : 0.01 : 1;
            ctfg3 = (1.816-4*(sqrt(1.816)-1)*(1-ag3))*fg;
            
            ag4=[ag2,ag3];
            ctfg4=[ctfg2,ctfg3];
            plot(ag4,ctfg4,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('Burton''s correction (2001)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method',...
            'Burton''s correction'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on
        
        elseif (brake_state_model) == 5  % Manwell correction (2002)
        % [ac = 0.4]
        for fg = 0.1 : 0.1 : 1
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1)*fg;                        % Momentum theory [ag < 0.4]
            
            plot(ag1,ctfg1,'r:','LineWidth',1);
            ag2 = 0 : 0.01 : 0.4;
            ctfg2 = 4*fg*ag2.*(1-ag2);
            
            ag3 = 0.4 : 0.01 : 1;
            ctfg3 = 0.96*fg+fg*(ag3-.4).*(fg*(ag3+0.4)-.286)/.6427;
            
            ag4=[ag2,ag3];
            ctfg4=[ctfg2,ctfg3];
            plot(ag4,ctfg4,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('Manwell''s correction (2002)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method',...
            'Manwell''s correction'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on
        
        
    elseif (brake_state_model) == 6 % Bossanyi's model (2004)
        % [ac = 0.4]
        for fg = 0.1 : 0.1 : 1
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1)*fg;                        % Momentum theory [ag < 0.4]
            
            plot(ag1,ctfg1,'r:','LineWidth',1);
            ag2 = 0 : 0.01 : 0.35;
            ctfg2 = 4*fg*ag2.*(1-ag2);
            
            ag3 = 0.36 : 0.01 : 1;
            ctfg3 = fg*(0.6+0.61*ag3+0.79*ag3.^2);
            
            ag4=[ag2,ag3];
            ctfg4=[ctfg2,ctfg3];
            plot(ag4,ctfg4,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('Bossanyi''s correction (2004)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method',...
            'Bossanyi''s correction'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on

        
    elseif (brake_state_model) == 7 % Buhl's model (2005)
        % [ac = 0.4]
        for fg = 0.1 : 0.1 : 1
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1)*fg;                        % Momentum theory [ag < 0.4]
            
            plot(ag1,ctfg1,'r:','LineWidth',1);
            ag2 = 0 : 0.01 : 0.4;
            ctfg2 = 4*fg*ag2.*(1-ag2);
            
            ag3 = 0.4 : 0.01 : 1;
            
            m0 = 2/(1-0.4)^2-4*fg;
            m1 = -4*0.4/(1-0.4)^2+4*fg;
            m2 = 2+(4*0.4-2)/(1-0.4)^2;
            
            ctfg3 = m0*ag3.^2+m1*ag3+m2;
            
            ag4=[ag2,ag3];
            ctfg4=[ctfg2,ctfg3];
            plot(ag4,ctfg4,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('Buhl''s correction (2005)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method',...
            'Buhl''s correction'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on
        
        
    elseif (brake_state_model) == 8  % Wilson model (1974)
        % [ac = 0.4]
        for fg = 0.1 : 0.1 : 1
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1)*fg;                        % Momentum theory [ag < 0.4]
            
            plot(ag1,ctfg1,'r:','LineWidth',1);
            
            ag2 = 0 : 0.01 : 0.36;
            ctfg2 = 4*fg*ag2.*(1-ag2);
            
            ag3 = 0.37 : 0.01 : 1;
            
%             m0 = (2-4*fg+4*fg^2*(0.4)*(2-0.4))/(1-0.4)^2;
%             m1 = (-4*0.4+4*fg*(1+0.4^2)-8*fg^2*0.4)/(1-0.4)^2;
%             m2 = (2*0.4^2-4*fg*0.4^2+4*fg^2*0.4^2)/(1-0.4)^2;
%             
%             ctfg3 = m0*ag3.^2+m1*ag3+m2;

            ctfg3 = 1.6*fg-4*(sqrt(1.6)-1)*(1-ag3)*fg;
            
            ag4=[ag2,ag3];
            ctfg4=[ctfg2,ctfg3];
            plot(ag4,ctfg4,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('Wilson''s correction (1974)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method',...
            'Wilson''s correction'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on
        
        
    elseif (brake_state_model) == 9     % Shen's model (2005) [ac = 1/3]
        
        for fg = 0.1 : 0.1 : 1
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1*fg)*fg;                        % Momentum theory [ag < 0.4]
            
            plot(ag1,ctfg1,'r:','LineWidth',1);
            
            ag2 = 0 : 0.01 : 0.33;
            ctfg2 = 4*fg*ag2.*(1-ag2*fg);
            
            ag3 = 0.33 : 0.01 : 1;
            ctfg3 = 4*(0.33^2*fg^2+(1-2*0.33*fg)*ag3*fg);
            
            ag4=[ag2,ag3];
            ctfg4=[ctfg2,ctfg3];
            plot(ag4,ctfg4,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('Shen''s correction (2005)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method with De Vries''s change',...
            'Shen''s correction'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on
        
      elseif (brake_state_model) == 10  % New correction model (2018)
        % [ac = 0.4]
        for fg = 0.1 : 0.1 : 1
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1*fg)*fg;                        % Momentum theory [ag < 0.4]
            
            plot(ag1,ctfg1,'r:','LineWidth',1);
            
            ag2 = 0 : 0.01 : 0.4;
            ctfg2 = 4*fg*ag2.*(1-ag2*fg);
            
            ag3 = 0.37 : 0.01 : 1;
            
            m0 = (2-4*fg+4*fg^2*(0.4)*(2-0.4))/(1-0.4)^2;
            m1 = (-4*0.4+4*fg*(1+0.4^2)-8*fg^2*0.4)/(1-0.4)^2;
            m2 = (2*0.4^2-4*fg*0.4^2+4*fg^2*0.4^2)/(1-0.4)^2;
            
            ctfg3 = m0*ag3.^2+m1*ag3+m2;
            ag4=[ag2,ag3];
            ctfg4=[ctfg2,ctfg3];
            plot(ag4,ctfg4,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('New correction model (2018)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method with De Vries''s change',...
            'New correction model'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on

        
    elseif (brake_state_model) == 0  % BEMT method
        
        for fg = 0.1 : 0.1 : 1
            
            ag1 = 0 : 0.01 : 1;
            ctfg1 = 4*fg*ag1.*(1-ag1);
            
            plot(ag1,ctfg1,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('BEMT method','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on
        
        
        
        
    elseif (brake_state_model) == 11  % BEMT method with De Vries''s change
        
        for fg = 0.1 : 0.1 : 1
            
            ag1 = 0 : 0.01 : 1;
            
            ctfg1 = 4*ag1.*(1-ag1*fg)*fg;                        % Momentum theory [ag < 0.4]
            
            plot(ag1,ctfg1,'b-','LineWidth',2)
            
        end
        
        xlabel('Axial induction factor, a','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        ylabel('Thrust coefficient, C_t','FontSize',10,'FontWeight','bold','FontName','Times New Man')
        title('BEMT method with De Vries''s change (1973)','FontSize',10,'FontWeight','bold','FontName','Times New Man');
        
        legend({'NACA TN-221 (4-Blade)',...
            'NACA TN-221 (2-Blade)',...
            'R&M 885-uv',...
            'R&M 885-cv',...
            'BEMT method with De Vries''s change'},...
            'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
        axis([0 1 0 2])
        legend boxoff
        box on
        
        
    end
end

%==========================================================================

