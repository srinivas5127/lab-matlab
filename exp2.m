clear all;
Qg=5; %Gas FLow-rate
Qo=5000; %Oil Flow rate
Qw=3000; %water flow rate
api=30; %Sg of oil in api
SGg=0.6; %Sg of gas
SGw=1.07; %Sg of water
p=100; %Operating Pressure
t=550; %operating temperature in rankine
MUo=10; %Oil viscosity 
MUw=1; %Water viscosity
DMl=100; %Droplet size in microns for liquid
DMw=500; %Droplet size in microns for water
DMo=200; %Droplet size in microns for oil
TRo=10; %Retention time in minutes for oil
TRw=10; %Retention time in minutes for water
z=0.99; %Compressibility factor
Cd=2.01; %Drag coefficent
SGo=141.5/(api+131.5);
Homax=((1.28*10^-3)*TRo*(SGo-SGw)*DMo*DMo)/MUo;
AWbyA=0.5*(Qw*TRw)/((Qo*TRo)+(Qw*TRw));
HObyD=0.25;
Dmax=Homax/HObyD;
pg=2.7*(SGg*p)/(t*z);
po=62.4*SGo;
DL=420*(t*z*Qg/p)*((pg*Cd)/(100*(po-pg)))^0.5;
DDl=1.429*((Qo*TRo)+(Qw*TRw));

for D=[60 72, 84, 96, 108]; 
   
    Lo=DDl/D^2;
    Lso=4*(Lo/3);
    SR=Lso*(12/D);
    Lg=DL/D;
    T = table(D, Lg, Lo , Lso, SR);
    disp(T);
end
