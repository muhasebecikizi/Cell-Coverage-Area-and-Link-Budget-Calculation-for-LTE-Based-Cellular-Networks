
function PL = Pathloss_3GPP(hb,fc,d,Terrain)

    A = 69.55 + 26.16*log10(fc) - 13.82*log10(hb);
    B = (44.9 - 6.55*log10(hb))*log10(d/1000);
    C = (-4.78)*log10(fc)^2 + 18.33*log10(fc)- 40.94;
    
    if (Terrain == 1)
      if(150 < fc < 400)
           PL = 40*(1-(4.10^-3)*hb)*log10(d/1000) - 18*log10(hb) + 21*log10(fc) + 80;
          
      end
      if (400 <= fc < 1500)
            PL = 40*(1-(4.10^-3)*hb)*log10(d/1000) - 18*log10(hb) + 21*log10(fc) + 80;
            
      end
    else
          PL = A+B+C;
    end
        
end
        