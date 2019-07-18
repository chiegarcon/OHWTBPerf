Nr=f(13)*60;
Tr=round(Nr);
Pr=round(60/Nr);
for i=1:Tr-1
    Smax(i,1)=max(y4(1+Pr*(i-1):Pr*i));
    Smin(i,1)=min(y4(1+Pr*(i-1):Pr*i));
end
if (Tr-1)*Pr~=60
    Smax(Tr,1)=max(y4(1+Pr*(Tr-1):end));
    Smin(Tr,1)=min(y4(1+Pr*(Tr-1):end));
end