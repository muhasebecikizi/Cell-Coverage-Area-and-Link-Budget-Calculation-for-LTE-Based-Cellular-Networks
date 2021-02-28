% --Investigate the percentage of connected users with different
%   sensitivities and Base station Power

%Link Budget Calculation Based LTE in Urban
fc = 800; %Carrier Frequency 800 MHz
fc2 = 900; %Carrier Frequency 900 MHz
fc3 = 1800; %Carrier Frequency  1800 MHz
fc4 = 2100; %Carrier Frequency 2100 MHz

BW = 10000000; %Bandwidth 10 MHz
Power_bs = 43;  %Power of Base Station in dBm
Power_bs2 = 63; %Power of second Base Station in dBm

axis([0 50000 0 50000]); 
xlabel('m')
ylabel('m')
hold on
theta = linspace(0,2*pi); % To see the antenna location clearly; a circle is skectched around it,angle theta for circle
User_Number = 1000;  %Number of Users

%Placing Base Station
Base_Station_Loc = [25000;25000];  %Location of Base Station                                                   
Rad = 1000;  %Radius of Base Station Location = 1000m
plot(Base_Station_Loc(1),Base_Station_Loc(2),'+')  %Center of Base Station
hold on
x = 25000 + Rad*cos(theta);
y = 25000 + Rad*sin(theta);
plot(x,y,'b');
title('Cell Coveredge of Rural Area')
hold on

%Randomly User Location
user = 50000*rand(2,1000); % 1000 Users in the Area (1000 users are randomly located in 2D Area)
x1=user(1,:);  % x coordinate of the user location
y1=user(2,:);  % y coordinate of the user location


%Calculation of Receiver Sensitivity
NF = 5;    %Noise Figure, for FDD Base Station in 3GPP technical Report
EbN0 = 14; % BER=10^-6
R = 6e6;   %Data Rate 6 Mbps
SNR = EbN0 + 10*log10(R/BW); % SNR Calculation
Noise_floor = -174 + (10*log10(BW)); %in dBm 
Sensitivity = Noise_floor + SNR + NF + 30; %Calculated Receiver Sensitivity % Converted dBm with +30

%Received Powers of Users from Base Station
for i=1:1000
 distance_1(i) = sqrt((x1(i)- Base_Station_Loc(1,1))^2 + (y1(i)- Base_Station_Loc(1,1))^2); %User Distances to Base Station Euclidian distance
 received_pow1(i) = Received_power_rural(Power_bs,distance_1(i),fc) + 30 ; %Converted to dBm with +30
 received_pow2(i) = Received_power_rural(Power_bs,distance_1(i),fc2) + 30 ;
 received_pow3(i) = Received_power_rural(Power_bs,distance_1(i),fc3) + 30 ;
 received_pow4(i) = Received_power_rural(Power_bs,distance_1(i),fc4) + 30 ;
end
% Received Powers of Users from Second Base Station
for i=1:1000
 distance_1(i) = sqrt((x1(i)- Base_Station_Loc(1,1))^2 + (y1(i)- Base_Station_Loc(1,1))^2); %User Distances to Base Station Euclidian distance
 received_pow1_2(i) = Received_power_rural(Power_bs2,distance_1(i),fc) + 30 ; %Converted to dBm with +30
 received_pow2_2(i) = Received_power_rural(Power_bs2,distance_1(i),fc2) + 30 ;
 received_pow3_2(i) = Received_power_rural(Power_bs2,distance_1(i),fc3) + 30 ;
 received_pow4_4(i) = Received_power_rural(Power_bs2,distance_1(i),fc4) + 30 ;
end


% Determine users who can connect the base station
Connected_users = find(received_pow1 > Sensitivity); %Find users in the area whose received power is greater than sensitivity for 800MHz

for k=1:1000
    if (~isempty(find(Connected_users == k)))== 0;
        %     isempty    This MATLAB function returns logical 1 (true) if A
        %     is an empty array and logical 0 (false) otherwise.
        %     find       Find indices and values of nonzero elements
    plot(x1(k),y1(k),'xr');
    hold on;
    else 
    plot(x1(k),y1(k),'*g');
    hold on;
    end 
end


distance_2 = 0:100:50000; % Observation interval for percentage, examine it for 100m

%Percentage for First Base Station at 800Mhz
for percentage=1:length(distance_2)
     temp = 0;
    for i=1:User_Number
      received_pow_800MHz(i)= Received_power_rural(Power_bs,distance_2(percentage),fc);
      if(received_pow_800MHz(i) > -70)
          temp=temp+1;
      else
          temp=temp;
      end      
    end
    Percentage_800(percentage)= temp/(User_Number)*100;  %Percentage for carrier freq. is 800MHz,Power of base station is 43dBm
end

% Percentage for Second Base Station at 800Mhz
for percentage=1:length(distance_2)
     temp = 0;
    for i=1:User_Number
      received_pow_800MHz_2(i)= Received_power_rural(Power_bs2,distance_2(percentage),fc);
      if(received_pow_800MHz_2(i) > -70) 
          temp=temp+1;
      else
          temp=temp;
      end      
    end
    Percentage_800_2(percentage)= temp/(User_Number)*100;  %Percentage for carrier freq. is 800MHz,Power of base station is 63dBm
end


% Percentage for First Base Station at 2100Mhz
for percentage=1:length(distance_2)
     temp = 0;
    for i=1:User_Number
      received_pow_2100MHz(i)= Received_power_rural(Power_bs,distance_2(percentage),fc4);
      if(received_pow_2100MHz(i) > -70)
          temp=temp+1;
      else
          temp=temp;
      end      
    end
    Percentage_2100(percentage)= temp/(User_Number)*100;  %Percentage for carrier freq. is 2100MHz,Power of base station is 43dBm
end

% Percentage for Second Base Station at 2100Mhz
for percentage=1:length(distance_2)
     temp = 0;
    for i=1:User_Number
      received_pow_2100MHz_2(i)= Received_power_rural(Power_bs2,distance_2(percentage),fc4);
      if(received_pow_2100MHz_2(i) > -70)
          temp=temp+1;
      else
          temp=temp;
      end      
    end
    Percentage_2100_2(percentage)= temp/(User_Number)*100;  %Percentage for carrier freq. is 2100MHz,Power of base station is 63dBm
end


figure(2)
plot(distance_2,Percentage_800,'r');
hold on
plot(distance_2,Percentage_800_2,'m');
title('Percentage - Distance graph at 800Mhz');
xlabel('meter')
ylabel('%')
legend('Tx power 43dB','Tx power 63dB');
grid on


figure(3)
plot(distance_2,Percentage_2100,'r');
hold on
plot(distance_2,Percentage_2100_2,'m');
title('Percentage - Distance graph at 2100Mhz');
xlabel('meter')
ylabel('%')
legend('Tx power 43dB','Tx power 63dB');
grid on



