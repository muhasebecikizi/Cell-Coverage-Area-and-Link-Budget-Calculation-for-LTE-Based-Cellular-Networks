function [Pr]= Received_power_urban(Pt,d,fc)

if (fc <= 900)
    Gtx = 12;    %dB Base station Antenna gain
else 
    Gtx = 15;
end 
Grx = 0;     %User antenna gain
hb = 15;     % Base Station Antenna Height
PL = 40*(1-(4.10^-3)*hb)*log10(d/1000) - 18*log10(hb) + 21*log10(fc) + 80; %Pathloss for urban

ShstdCell = 9;
NCellUsers = 10;

for n = 1:length(d)
    ShadowingCell(n) = ShstdCell*randn;
    AverageGainCell(n) = (10^(PL(n)/10)*((10^(ShadowingCell(n)/10)))); %shadowing
end
% Pr = (Pt + Grx + Gtx - PL); % For without shadowing
Pr = (Pt + Grx + Gtx - 10*log10(AverageGainCell)); %Received Power with Pathloss + Shadowing

end