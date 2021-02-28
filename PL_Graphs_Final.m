
Cell_size1 = 15000; % Area of the Urban 15km
Sample_size1= 1000; % User number
Distance1 = linspace(0,Cell_size1,Sample_size1); %Distance from BS

Cell_size2 = 50000; % Area of the Rural 50km
Sample_size2= 1000; % User number
Distance2 = linspace(0,Cell_size2,Sample_size2); %Distance from BS

ShstdCell = 9;
NCellUsers = 10;

hb_u = 30; %Base Station Antenna Height - Urban
hb_r = 30; %Base Station Antenna Height - Rural

%-----------------Pathloss - Urban-----------------------------%
figure(1)
pathloss_u1 = Pathloss_3GPP(hb_u, 800, Distance1, 1);
plot(Distance1,pathloss_u1,'r','LineWidth', 1)
hold on
pathloss_u2= Pathloss_3GPP(hb_u, 900, Distance1, 1);
plot(Distance1,pathloss_u2,'b','LineWidth', 1)
hold on
pathloss_u3 = Pathloss_3GPP(hb_u, 1800, Distance1, 1);
plot(Distance1,pathloss_u3,'c','LineWidth', 1)
hold on
pathloss_u4 = Pathloss_3GPP(hb_u, 2100, Distance1, 1);
plot(Distance1,pathloss_u4,'m','LineWidth', 1)

title('3GPP Model - Urban, hb = 30m');
xlabel('Distance [meter]');
ylabel('Pathloss [dB]');
legend('800MHz','900MHz','1800MHz','2100MHz');
grid on;

%-----------------Pathloss - Rural -----------------------------%
figure(2)
pathloss_r1= Pathloss_3GPP(hb_r, 800, Distance2, 0);
plot(Distance2,pathloss_r1,'r','LineWidth', 1)
hold on
pathloss_r2= Pathloss_3GPP(hb_r, 1900, Distance2, 0);
plot(Distance2,pathloss_r2,'b','LineWidth', 1)
hold on
pathloss_r3= Pathloss_3GPP(hb_r, 1800, Distance2, 0);
plot(Distance2,pathloss_r3,'c','LineWidth', 1)
hold on
pathloss_r4= Pathloss_3GPP(hb_r, 2100, Distance2, 0);
plot(Distance2,pathloss_r4,'m','LineWidth', 1)
title('3GPP Model - Rural, hb = 30m');
xlabel('Distance [meter]');
ylabel('Pathloss [dB]');
legend('800MHz','900MHz','1800MHz','2100MHz');
grid on;


%----------------------Pathloss + Shadowing for Urban----------------%

for n = 1:length(Distance1)
    ShadowingCell_1(n) = ShstdCell*randn;
    AverageGainCell_1(n) = (10^(pathloss_u1(n)/10)*(10^(ShadowingCell_1(n)/10)));
    
    ShadowingCell_2(n) = ShstdCell*randn;
    AverageGainCell_2(n) = (10^(pathloss_u2(n)/10)*(10^(ShadowingCell_2(n)/10)));
    
    ShadowingCell_3(n) = ShstdCell*randn;
    AverageGainCell_3(n) = (10^(pathloss_u3(n)/10)*(10^(ShadowingCell_3(n)/10)));
    
    ShadowingCell_4(n) = ShstdCell*randn;
    AverageGainCell_4(n) = (10^(pathloss_u4(n)/10)*(10^(ShadowingCell_4(n)/10)));
end

%----------------------Pathloss + Shadowing for Rural----------------%

for j = 1:length(Distance2)
    ShadowingCell_5(j) = ShstdCell*randn;
    AverageGainCell_5(j) = (10^(pathloss_r1(j)/10)*(10^(ShadowingCell_5(j)/10)));
    
    ShadowingCell_6(j) = ShstdCell*randn;
    AverageGainCell_6(j) = (10^(pathloss_r2(j)/10)*(10^(ShadowingCell_6(j)/10)));
    
    ShadowingCell_7(j) = ShstdCell*randn;
    AverageGainCell_7(j) = (10^(pathloss_r3(j)/10)*(10^(ShadowingCell_7(j)/10)));
    
    ShadowingCell_8(j) = ShstdCell*randn;
    AverageGainCell_8(j) = (10^(pathloss_r4(j)/10)*(10^(ShadowingCell_8(j)/10)));
end

figure(3)
plot(Distance1,10*log10(AverageGainCell_1),'m--')
hold on
plot(Distance1,pathloss_u1,'b','LineWidth', 1)
title('3GPP Model - Urban - 800MHz; Path Loss & User Location')
xlabel('Location of Cellular Users (m)');
ylabel('Path Loss(dB)');
grid on
legend('Pathloss + Shadowing','Pathloss');

figure(4)
hold on
plot(Distance1,10*log10(AverageGainCell_4),'m--')
hold on
plot(Distance1,pathloss_u4,'b','LineWidth', 1)
title('3GPP Model - Urban - 2100MHz; Path Loss & User Location')
xlabel('Location of Cellular Users (m)');
ylabel('Path Loss(dB)');
grid on
legend('Pathloss + Shadowing','Pathloss');

figure(5)
plot(Distance2,10*log10(AverageGainCell_5),'m--')
hold on
plot(Distance2,pathloss_r1,'b','LineWidth', 1)
title('3GPP Model - Rural - 800MHz; Path Loss & User Location')
xlabel('Location of Cellular Users (m)');
ylabel('Path Loss(dB)');
grid on
legend('Pathloss + Shadowing','Pathloss');

figure(6)
plot(Distance2,10*log10(AverageGainCell_8),'m--')
hold on
plot(Distance2,pathloss_r4,'b','LineWidth', 1)
title('3GPP Model - Rural - 2100MHz; Path Loss & User Location')
xlabel('Location of Cellular Users (m)');
ylabel('Path Loss(dB)');
grid on
legend('Pathloss + Shadowing','Pathloss');














