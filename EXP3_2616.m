clc;
clear all;
p=1;%operating pressure
T1=528;%Inlet temperature
T2=648;%Outlet temperature
T=588;%Avg temperature
Tw=680;%pipe wall temperature
T3=492;%temperature
m1=29;%mass of air
v=359;%volume at standard conditions
Va=1.5;%velocity of air
s=0.0233;%cross sectional area
ua=0.019;%viscosity of air
A=0.5411;%contact area
K=0.0163;%thermal conductivity
uw=0.021;%viscosity of water
dn=2;%pipe nominal diameter
do=2.067;%pipe outside diameter
g=32.174;%gravity
cp=0.25;
r=0.0676;%density
D=2.067/12;
pa=(m1*T3)/(v*T1);
G=Va*pa*3600;% mass velocity
fprintf('Mass velocity is %d lb/(ft^2.hr) \n',G);
m=G*s;%mass flow rate
fprintf('Mass flow rate is %d Lb/hr \n',m)
Re=(D*G)/(ua*2.42);% Renoylds number
fprintf('Renoylds number is %d  \n',Re)
Q=m*cp*(T2-T1);% heat transfer
dt1=Tw-T2;
dt2=Tw-T1;
LMTD=(dt2-dt1)/log(dt2/dt1);
L=((Q/(A*LMTD))*(D/(2*K))*((K/(m*cp))^(1/3))*((uw/ua)^0.14))^1.5; %length
B=1/T;
dtw=Tw-T;
NG=((D^3)*(pa^2)*g*B*dtw)/(ua*0.000672)^2;%Grashoff number
Qm=2.25*(1+0.01*(NG)^(1/3))/log10(Re);
L1=L/Qm;
fprintf('The length of the heated section is %d feet \n',L1);