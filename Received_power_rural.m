function [Pr]= Received_power_rural(Pt,d,fc)

if (fc <= 900)
    Gtx = 12;    %dB Base station Antenna gain
else 
    Gtx = 15;
end 
Grx = 0;     %User antenna gain
hb = 30;     % base station antenna height
PL= 69.55 + 26.16*log10(fc) - 13.82*log10(hb)+(44.9 - 6.55*log10(hb))*log10(d/1000)+(-4.78)*log10(fc)^2 + 18.33*log10(fc)- 40.94; %Pathloss for Rural

ShstdCell = 9;
NCellUsers = 1000;

for n = 1:length(d)
    ShadowingCell(n) = ShstdCell*randn;
    AverageGainCell(n) = (10^(PL(n)/10)*((10^(ShadowingCell(n)/10)))); %shadowing
end
%  Pr = (Pt + Grx + Gtx - PL); % For without shadowing
 Pr = (Pt + Grx + Gtx - 10*log10(AverageGainCell)); %Received Power with Pathloss + Shadowing

end