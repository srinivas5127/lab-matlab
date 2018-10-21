clc;

Qg=10;
Qo=2000;
P=1000;
T=520;
dm=140;
tr=3;
z=0.84;
ug=0.013;
sg=0.6;
pw=62.4;
API=40;
 r0=(141.5/(131.5+API));
pg=2.7*((sg*P)/(T*z))
po=pw*r0
cd(1)=0.34;
for D=2:10
    u(D)=0.01186*(((po-pg)/(pg))*(dm /(cd(D-1))))^0.5;                                                                      
    Re(D)=0.0049*((pg*dm*u(D))/ug);
    cd(D)=0.34+(3/(Re(D)^0.5))+(24/Re(D));
end  

disp('drag cofficient');
disp(cd)

E=(Qg*T*z/P);
W=(pg/(po-pg));
A=cd(D)/dm;
LD=422*E*((W*A)^0.5);
disp('Gas capacity constraint');
disp(LD)

K=1.428*Qo*tr;
disp('Oil capacity constraint');
disp(K)

for D=[30,32,34,36,38,40,42];
    Lg= (40.15/D);
    Lsg= (Lg)+(D/12);
    Lo= (8568/(D^2));
    Lso= (4*Lo)/3;
    sr= (12*Lso)/D;
    T= table( D,Lg,Lsg,Lo,Lso,sr);
    disp(T);
end
