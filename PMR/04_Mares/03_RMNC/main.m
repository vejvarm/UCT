%% Rekurentní metoda nejmenších ètvercù
%% dùležité parametry
% -- VZORKOVÁNÍ A ÈAS --
Ts = 5;
tmax = 1000;
tspan = 0:Ts:tmax;
Nt = length(tspan);

% --- VSTUPNÍ SIGNÁL ---
% u = linspace(0,1,Nt)';
% u = ones(Nt,1);
u = [linspace(0,1,floor(Nt/2))'; ones(ceil(Nt/2),1)];
% u = rand(Nt,1);

% -- SKUTEÈNÁ SOUSTAVA --
ka = 5;
Ta = 20;
eps = 0.1;
B = ka;
A = [Ta^2 2*eps*Ta 1];
[Bz,Az] = c2dm(B,A,Ts);

% -- IDENTIFIKOVANÁ SOUSTAVA --
nb = length(nonzeros(Bz));
na = length(Az);
init_ratio = 0.1;  % z jaké èásti dostupných dat se bude provádìt inicializace matic B a P (B0,P0)

%% diskrétní pøenos skuteèné soustavy
Fz = tf(Bz,Az,Ts);

% odezva skuteèné soustavy na specificky vstupní signal u v èasech tspan
y = lsim(Fz,u,tspan);
    
%% vykreslení odezvy simulované soustavy
figure(1)
    subplot(211)
    stairs(tspan,y)
    hold on
    stairs(tspan,u)
    hold off
    title('Skuteèná soustava')
    xlabel('èas (s)')
    ylabel('y,u')
    legend('odezva soustavy (y)','vstupní signál (u)')
     
%% inicializace identifikace
% inicializace matic B a P (B0,P0)
init_length = floor(init_ratio*length(y));  % délka inicializaèních dat
u0 = u(1:init_length);
y0 = y(1:init_length);
[P,B] = calcBandP(nb,na,y0,u0);
% B = ones(size(B));
% P = 0.2*rand(size(P));
K = P*B;

%% Testování (mírná úprava parametrù reálné soustavy)
% simulace reálné soustavy s mírnou úpravou parametrù
Bz_new = Bz - 0.01;
Az_new = Az - [0,0.03,-0.03];
Fz = tf(Bz_new,Az_new,Ts);
y = lsim(Fz,u,tspan);

%% identifikace pomocí RMNÈ
figure(1)
    subplot(212)
for i = init_length:length(y)-na
    % identifikace parametrù pomocí RMNÈ
    [P,K] = rmnc(nb,na,y(i:i+na-1),u(i:i+nb),P,K);
    
    % osamostatneni nul a pólù
    Bi = K(1:nb);
    Ai = [1; K(nb+1:end)];
    
    % simulace soustavy s identifikovanými parametry
    Fzi = tf(Bi',Ai',Ts);
    yi = lsim(Fzi,u,tspan);
    
    % vykreslení identifikované soustavy
    plot(tspan,y,tspan,yi,tspan(1:i),yi(1:i));
    drawnow
end
    title('Identifikovaná soustava')
    xlabel('èas (s)')
    ylabel('yi')

% suma ètvercù odchylek
R = sumsqr(yi - y);

%% vykreslení posledních identifikovaných parametrù
figure(2)
    set(2,'DefaultlineLineWidth',2)
    plot(tspan,y,'-b',tspan,yi,'-.r')
    xlabel('èas (s)')
    ylabel('y')
    title(sprintf('Porovnání skuteèné a identifikované soustavy (R = %.2f)',R))
    legend('odezva skuteèné soustavy','odezva identifikované soustavy')

