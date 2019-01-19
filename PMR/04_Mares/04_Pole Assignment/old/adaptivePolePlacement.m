%% TODO: y == k*yi protože -->
%% TODO: --> Bi se identifikuje špatnì!


%% týden 4: Úkol 1 - 2DOF regulace
% clear
close all

% -- VZORKOVÁNÍ A ÈAS --
Ts = 5;
tmax = 1000;
tspan = 0:Ts:tmax;
N = length(tspan);

% -- SKUTEÈNÁ SOUSTAVA --
ka = 1;
Ta = 20;
eps = 1;
B = ka;
A = [Ta^2 2*eps*Ta 1];
% A = [1 2 3 4];
[B,A] = c2dm(B,A,Ts,'zoh');

% -- IDENTIFIKOVANÁ SOUSTAVA --
nb = length(nonzeros(B));   % nb predchozich vstupu na prave strane (+1 aktualni pokud m = n)
na = length(A);             % na-1 vystupu je na prave strane
delay = na - nb - 1;        % o kolik je rad jmenovatele vyssi nez rad citatele (zpozdeni)

% odstraneni nul #POÈÍTAT S NULOU NEBO NE???
% B = nonzeros(B)'; % vrati sloupcovy vektor
% B = B(find(B,1,'first'):end); % odstraneni nul z pocatku vektoru

% inicializace promìnných
t = 0:Ts:(N+na-2)*Ts;
u = zeros(N+na-1,1); % u(1) = u(k) ; u(2) = u(k+1) ; u(3) = u(k+2); ...
y = zeros(N+na-1,1); % y(1) = y(k) ; y(2) = y(k+1) ; y(3) = y(k+2) ; ...
e = ones(N+na-1,1);
w = 10*ones(N+na-1,1); % øídicí velièina
yreal = lsim(tf(B,A,Ts),w);

%% Inicializace RMNÈ
init_length = 5;
[Brmnc,Prmnc] = calcBandP(nb,na,yreal(1:init_length),w(1:init_length));
% Brmnc = 0.5*rand(size(Brmnc));
% Prmnc = 1*rand(size(Prmnc));
Krmnc = Brmnc*Prmnc;


%% REGULÁTOR
% volba nových pozic pólù systému v diskrétní oblasti
% poles = [-0.1+0.2i -0.1-0.2i];
% poles = [-1+1i -1-1i -0.5 -0.8];
% roznásobení:
% charPol = poly(poles);
% požadovaný charakteristický polynom v diskrétní oblasti
% [~,D] = c2dm(1,charPol,Ts);

D = [1 -0.8 0.07];

%% rozhodnutí o øádu polynomù P a Q:
nA = length(A)-1;
nB = length(B)-1;
nD = length(D)-1;

if nA + nB > nD
    nQ = nA - 1;
else
    nQ = nD - nB - 1;
end

nP = nB - 1;

%% prùbìh regulaèního pochodu
figure(1)
for k = na:N
    
    if delay == 0
        u(k) = u(k-1);
    end
    
    % Adaptivní regulace
    % výpoèet parametrù modelu soustavy pomocí RMNÈ
    % identifikace parametrù pomocí RMNÈ
    [Bi,Ai,Brmnc,Prmnc,Krmnc] = rmnc(nb,na,y(k-na+1:k),u(k-nb:k),Brmnc,Prmnc,Krmnc);
    
%     D = A; % TODO: change!!!
    
    % výpoèet výstupu modelu
    Fzi = tf(Bi',Ai',Ts);
    yi = lsim(Fzi,u,t);
    
    % výpoèet výstupu reálné soustavy
    y(k) = (B*u(k-delay:-1:k-na+1) - A(2:end)*y(k-1:-1:k-na+1))/A(1);
    e(k) = w(k) - y(k);
    
    % porovnání identifikované soustavy s reálnou
    plot(t,y,t(1:k),yi(1:k));
    drawnow
    
    %% Sylvestrova matice pro vyøešení polynomù P a Q
    dims = nA + nB; % rozmìry matice
    M = zeros(dims,dims);
    % naplnìní matice
    % 1. èást (naplnìní polynomem A)
    for index = 1:nB
        M(index:index+nA,index) = Ai;
    end
    % 2. èást (naplnìní polynomem B)
    for index = nB+1:dims
       M(index-nB:index,index) = [0; Bi];
    end

    % vektor pravých stran:
    b = zeros(dims,1);
    b(1:nD+1) = D';

    % výpoèet soustavy rovnic
    PQ = M\b; % ekvivalent inv(M)*b

    % rozdìlení výsledku do vektorù P a Q
    P = PQ(1:nP+1)';
    Q = PQ(nP+2:end)';
    
    %% výpoèet R
    R = sum(D)/sum(Bi); %R/D pro z = 1

    if nP > 0 % u(k) závislé i na pøedchozích akèních zásazích (u)
        u(k) = (R*w(k) - Q*y(k:-1:k-nQ) - P(2:end)*u(k-1:-1:k-nP))/P(1);
    else % u(k) závsilé jen na výstupech ze soustavy
        u(k) = (R*w(k) - Q*y(k:-1:k-nQ))/P(1);
    end
    
end

lenOfData = N+na-1-1;

% posunutí jednu iteraci pøed poèátek zmìn u(k) (odøíznutí inicializaèních hodnot)
y = y(na-1:lenOfData);
e = e(na-1:lenOfData);
u = u(na-1:lenOfData);

figure(3)
    subplot(311)
        stairs(tspan,u)
            title('Akèní zásah == výstup z regulátoru')
            xlabel('iterace (k)')
            ylabel('u(k)')
            xlim([0,tspan(end)])
            grid on
    subplot(312)
        stairs(tspan,y)
            hold on
            title('Regulovaná velièina == výstup ze soustavy')
            xlabel('iterace (k)')
            ylabel('y(k)')
            xlim([0,tspan(end)])
            grid on
    subplot(313)
        stairs(tspan,e)
            title('Regulaèní odchylka == w(k) - y(k)')
            xlabel('iterace (k)')
            ylabel('e(k)')
            xlim([0,tspan(end)])
            grid on
        
%%
% figure(2)
%     step(c2d(tf(cit,jm),T,'zoh'))
%     hold on
%     plot(time,y,'-r')
     