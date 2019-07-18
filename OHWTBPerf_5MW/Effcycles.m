clc
clear
close all

addpath(genpath([fullfile(cd),'\OHWTBfunctions'])); 
%Add directories to search path

main_dir = which('OHWTBMain.m');
main_dir(length(main_dir)-10:length(main_dir)) = [];

blade_dir = [main_dir,'BladeData\ExistData\'];
bfname = [blade_dir,'speed2stress.dat'];

topology = OHWTBData(bfname,4,3,0);
wind_speed = topology(:,2);
stress = topology(:,4);

ii=1;
while ii<=60
x3=wblrnd(8,2,1);
if x3>=3 && x3<=25
    x4(ii)=x3;
    ii=ii+1;
end
end
y4=zeros(1);
t4=zeros(1);
for i=1:length(x4)
    t4(i)=1/60*i;
    y4(i)=interp1(wind_speed,stress,x4(i),'linear');
    
end


figure
hold on

subplot(211);
plot(t4*60,x4,'k','LineWidth',0.01)
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
legend({'wind speed spectrum'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
xlabel({'Time [min]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Speed [m/s]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
legend boxoff
axis([0 60 0 30])

subplot(212);
plot(t4*60,y4,'b','LineWidth',0.01)
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
legend({'Stress spectrum'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northwest')
xlabel({'Time [min]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Stress [MPa]'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([0 60 0 200])
legend boxoff
set (gcf,'Position',[300 300 600 400], 'color','w')
box on
print -djpeg WindStressSpe.jpg





Fs = 1;               % Sampling frequency
T = 1/Fs;             % Sampling period
L = length(y4);       % Length of signal
t = (0:L-1)*T;        % Time vector




Y = fft(y4);
P2 = abs(Y/L);
P1 = P2(1:L/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(L/2))/L;

A2 = angle(Y);
A1 = A2(1:L/2+1);
A1(2:end-1) = 2*A1(2:end-1);

figure;
subplot(211);
hold on
plot(f,P1,'k','LineWidth',0.01);

j=1;
for i=3:15
    if P1(i)>P1(i-1)&&P1(i)>P1(i+1)
        ra(j)=i;
        plot(f(i),P1(i),'ro','LineWidth',0.01);
        j=j+1;
        fprintf('%i\n',i);
    end
end
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
legend({'Fast Fourier transform'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northeast')
xlabel({'Frequency (cycle/min)'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Amplitude spectrum'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
legend boxoff
box on
axis([0 0.5 0 20])

subplot(212);
plot(f,A1,'b','LineWidth',0.01);
set(gca,'FontSize',8,'FontWeight','bold','FontName','Times New Man')
legend({'Fast Fourier transform'},'FontSize',8,'FontWeight','normal','FontName','Times New Man','Location','northeast')
xlabel({'Frequency (cycle/min)'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
ylabel({'Phase spectrum'},'FontSize',10,'FontWeight','bold','FontName','Times New Man')
axis([0 0.1 -10 10])
legend boxoff
set (gcf,'Position',[100 100 600 400], 'color','w')
box on

print -djpeg CyclesStressFFT.jpg

for j=1:length(ra)
Nr=f(ra(j))*60;
Tr=round(Nr);
Pr=round(60/Nr);
for i=1:Tr-1
    Smax(i,j)=max(y4(1+Pr*(i-1):Pr*i));
    Smin(i,j)=min(y4(1+Pr*(i-1):Pr*i));
end
if (Tr-1)*Pr~=60
    Smax(Tr,length(ra))=max(y4(1+Pr*(Tr-1):end));
    Smin(Tr,length(ra))=min(y4(1+Pr*(Tr-1):end));
end

end

