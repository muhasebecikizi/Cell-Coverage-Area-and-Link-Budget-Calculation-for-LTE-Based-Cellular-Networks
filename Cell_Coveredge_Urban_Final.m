
%Link Budget Calculation Based LTE in Urban
fc = 800; %Carrier Frequency of BS 800 MHz
fc2 = 900; %Carrier Frequency of BS 900 MHz
fc3 = 1800; %Carrier Frequency of BS 1800 MHz
fc4 = 2100; %Carrier Frequency of BS 2100 MHz

BW = 10000000; %Bandwidth 10 MHz
Power_bs = 43;  %Power of Base Station in dBm

axis([0 15000 0 15000]); 
xlabel('m')
ylabel('m')
hold on
theta= linspace(0,2*pi); % To see the antenna location clearly; a circle is skectched around it,angle theta for circle
User_Number = 1000;  %Number of Users

%Placing Base Station
Base_Station_Loc = [7500;7500];  %Location of Base Station                                                   
Rad = 250;  %Radius of Base Station Area = 250m
plot(Base_Station_Loc(1),Base_Station_Loc(2),'+')  %Center of Base Station
hold on
x = 7500 + Rad*cos(theta);
y = 7500 + Rad*sin(theta);
plot(x,y,'b');
title('Cell Coveredge for Urban Area ')
hold on

%Randomly User Location
user = 15000*rand(2,1000);  % 1000 Users in the Area (1000 users are randomly located in 2D Area)
x1=user(1,:); % x coordinate of the user location
y1=user(2,:); % y coordinate of the user location


%Calculation of Receiver Sensitivity

NF = 5;    %Noise Figure for FDD Base Station in 3GPP technical Report
EbN0 = 14; % BER=10^-6
R = 6e6;   %Data Rate 6 Mbps
SNR = EbN0 + 10*log10(R/BW); % SNR Calculation
Noise_floor = -174 + (10*log10(BW)); %in dBm 
Sensitivity = Noise_floor + SNR + NF + 30; %Calculated Receiver Sensitivity, Converted dBm with +30


%Received Powers of Users from Base Station 
for i=1:1000
 distance_1(i) = sqrt((x1(i)- Base_Station_Loc(1,1))^2 + (y1(i)- Base_Station_Loc(1,1))^2); %User Distances to BS Euclidian distance
 received_pow1(i) = Received_power_urban(Power_bs,distance_1(i),fc) + 30 ; %Converted to dBm with +30
 received_pow2(i) = Received_power_urban(Power_bs,distance_1(i),fc2) + 30 ;
 received_pow3(i) = Received_power_urban(Power_bs,distance_1(i),fc3) + 30 ;
 received_pow4(i) = Received_power_urban(Power_bs,distance_1(i),fc4) + 30 ;
end


% Determine users who can connect the base station

Connected_users = find(received_pow1 > Sensitivity); %Find users in the area whose received power is greater than sensitivity for 800MHz

for j = 1:1000
    if (~isempty(find(Connected_users == j)))== 0;
        %     isempty    This MATLAB function returns logical 1 (true) if A
        %     is an empty array and logical 0 (false) otherwise.
        %     find       Find indices and values of nonzero elements
    plot(x1(j),y1(j),'xr'); % Marked users with red who cannot connect to Base station
    hold on;
    else
    plot(x1(j),y1(j),'*g'); % Marked users with green who can connect to Base station
    hold on;
    end 
end

distance_2 =0:100:15000; % Observation interval for percentage, examine it for 100m

for percentage=1:length(distance_2)
     temp = 0;
    for i=1:User_Number
      received_pow_800MHz(i)= Received_power_urban(Power_bs,distance_2(percentage),fc);
      if(received_pow_800MHz(i) > Sensitivity)
          temp = temp + 1;
      else
          temp = temp;
      end      
    end
    Percentage_800(percentage)= temp/(User_Number)*100; %Percentage for carrier freq. is 800MHz
end

for percentage=1:length(distance_2)
     temp = 0;
    for i=1:User_Number
      received_pow_900MHz(i)= Received_power_urban(Power_bs,distance_2(percentage),fc2);
      if(received_pow_900MHz(i) > Sensitivity)
          temp=temp+1;
      else
          temp=temp;
      end      
    end
    Percentage_900(percentage)= temp/(User_Number)*100; %Percentage for carrier freq. is 900MHz
end

for percentage=1:length(distance_2)
     temp = 0;
    for i=1:User_Number
      received_pow_1800MHz(i)= Received_power_urban(Power_bs,distance_2(percentage),fc3);
      if(received_pow_1800MHz(i) > Sensitivity)
          temp=temp+1;
      else
          temp=temp;
      end      
    end
    Percentage_1800(percentage)= temp/(User_Number)*100; %Percentage for carrier freq. is 1800MHz
end
for percentage=1:length(distance_2)
     temp = 0;
    for i=1:User_Number
      received_pow_2100MHz(i)= Received_power_urban(Power_bs,distance_2(percentage),fc4);
      if(received_pow_2100MHz(i) > Sensitivity)
          temp=temp+1;
      else
          temp=temp;
      end      
    end
    Percentage_2100(percentage)= temp/(User_Number)*100; %Percentage for carrier freq. is 2100MHz
end

figure(2)
plot(distance_2,Percentage_800,'r');
hold on
plot(distance_2,Percentage_900,'g');
hold on
plot(distance_2,Percentage_1800,'b');
hold on
plot(distance_2,Percentage_2100,'m');
title('Percentage - Distance');
xlabel('m')
ylabel('%')
legend('800Mhz','900Mhz','1800Mhz','2100MHz');
grid on


