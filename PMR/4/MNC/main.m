%% Metoda nejmenších ètvercù

tspan = 0:0.1:10;
Nt = length(tspan);
% u = linspace(0,1,Nt)';
u = [linspace(0,1,floor(Nt/2))'; ones(ceil(Nt/2),1)];

%% prenos funkce, ktera bude identifikovana
A = [1 0.01 0.2];
B = 1;
T = 0.1;
Fz = tf(B,A,T);

% odezva systemu na specificky vstupni signal u v casech tspan
y = lsim(Fz,u,tspan);
% y = y + 0.01*randn(Nt,1);
    
%%
figure(1)
    stairs(tspan,y)
    hold on
    stairs(tspan,u)
    hold off
    
%%
[B,A] = mnc(1,3,y,u);

%%
Fzi = tf(B,A',T);

y = lsim(Fzi,u,tspan);
figure(1)
    hold on
    stairs(tspan,y)
    hold off

