addpath('fce\')
%% Metoda nejmenších ètvercù

Ts = 0.1;
tmax = 40;
tspan = 0:Ts:tmax;
Nt = length(tspan);
% u = linspace(0,1,Nt)';
u = ones(Nt,1);
% u = u + 0.1*rand(size(u));
% u = [linspace(0,1,floor(Nt/2))'; ones(ceil(Nt/2),1)];

%% prenos funkce, ktera bude identifikovana
% B = [2 2];
% A = poly([-0.5+2i,-0.5-2i,-2+0.1i,-2-0.1i,-1,-3]);
B = [2 2];
A = poly([-0.1+0.5i -0.1-0.5i -0.5 -0.7 -0.5]);
% B = 1;
% A = poly(-0.5 -0.2);
[Bz,Az] = c2dm(B,A,Ts);
Fz = tf(Bz,Az,Ts);

% odezva systemu na specificky vstupni signal u v casech tspan
y = lsim(Fz,u,tspan);
y = y + 0.2*randn(size(y));

%%
na = length(Az) + 50;
nb = length(nonzeros(Bz)) + 50;
    
%%
figure(1)
    p{1} = stairs(tspan,y);
    hold on
    p{2} = stairs(tspan,u);
    hold off
     
%% aproximace parametrù soustavy metodou nejmenších ètvercù
[Bi,Ai] = mnc(nb,na,y,u);

%% identifikovaná soustava
Fzi = tf(Bi',Ai',Ts);
yi = lsim(Fzi,u,tspan);

%% vykreslení
figure(1)
    hold on
    p{3} = stairs(tspan,yi);
    hold off
    
    legend('y_{orig}','u','y_{ident}')
    cellfun(@(p) set(p,'LineWidth',2), p)
