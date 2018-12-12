%% Rekurentní metoda nejmenších ètvercù

Ts = 0.1;
tmax = 100;
tspan = 0:Ts:tmax;
Nt = length(tspan);
% u = linspace(0,1,Nt)';
u = ones(Nt,1);
% u = [linspace(0,1,floor(Nt/2))'; ones(ceil(Nt/2),1)];

%% prenos funkce, ktera bude identifikovana
ka = 1;
Ta = 2;
eps = 0.8; 
B = ka;
A = [Ta^2 2*eps*Ta 1];
% Fs = tf(B,A);
[Bz,Az] = c2dm(B,A,Ts);
Fz = tf(Bz,Az,Ts);

% odezva systemu na specificky vstupni signal u v casech tspan
y = lsim(Fz,u,tspan);
% y = y + 0.01*randn(Nt,1);
    
%%
figure(1)
    stairs(tspan,y)
    hold on
    stairs(tspan,u)
    hold off
     
%% inicializace parametrù
nb = 1;
na = 3;
[B0,P0] = calcBandP(nb,na,y,u);



%% vykreslení
Fzi = tf(Bi',Ai',Ts);

yi = lsim(Fzi,u,tspan);
figure(1)
    hold on
    stairs(tspan,yi)
    hold off

