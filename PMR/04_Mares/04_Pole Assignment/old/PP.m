%% týden 4: Úkol 1 - 2DOF regulace
% clear all
close all

%% SOUSTAVA
% cit = [1];
% jm = [1 2 1];
cit = [1.5];
jm = [5 5 1];
% cit = [3 4 1];
% jm = [5 3 3 4];
T = 1;
N = 30;
time = 0:T:(N-1)*T;

w = 10; % øídicí velièina

% diskretizace
[B,A] = c2dm(cit,jm,T,'zoh');

% odstraneni nul #POÈÍTAT S NULOU NEBO NE???
% B = nonzeros(B); % vrati sloupcovy vektor
% B = B(find(B,1,'first'):end); % odstraneni nul z pocatku vektoru

% pocet parametru (pocet nenulovych elementu)
lenIN = length(B) - 1;      % lenIN predchozich vstupu na prave strane (+1 aktualni pokud m = n)
lenOUT = length(A) - 1;     % lenOUT vystupu je na prave strane
delay = lenOUT - lenIN;     % o kolik je rad jmenovatele vyssi nez rad citatele (zpozdeni)

% inicializace promìnných
u = zeros(N+lenOUT,1); % u(1) = u(k) ; u(2) = u(k+1) ; u(3) = u(k+2); ...
y = zeros(N+lenOUT,1); % y(1) = y(k) ; y(2) = y(k+1) ; y(3) = y(k+2) ; ...
e = ones(N+lenOUT,1);

%% REGULÁTOR
% volba nových pozic pólù systému (ve spojité oblasti)
poles = [-0.1+0.2i -0.1-0.2i];
% poles = [-1+1i -1-1i -0.5 -0.8];
% roznásobení:
charPol = poly(poles);
% požadovaný charakteristický polynom v diskrétní oblasti
[~,D] = c2dm(1,charPol,T);

% % diskretne
% D = [1 -0.8 0.07];
% roots(D)

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

%% Sylvestrova matice pro vyøešení polynomù P a Q
dims = nA + nB; % rozmìry matice
M = zeros(dims,dims);
% naplnìní matice
% 1. èást (naplnìní polynomem A)
for index = 1:nB
    M(index:index+nA,index) = A';
end
% 2. èást (naplnìní polynomem B)
for index = nB+1:dims
   M(index-nB:index,index) = B';
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
R = sum(D)/sum(B); %R/D pro z = 1

%% prùbìh regulaèního pochodu
for k = 1+lenOUT:N+lenOUT

    if delay == 0
        u(k) = u(k-1);
    end
    
    % TODO: Adaptivní regulace
    % výpoèet parametrù modelu pomocí RMNÈ
    % výpoèet výstupu modelu
    
    y(k) = (B*u(k-delay:-1:k-lenOUT) - A(2:end)*y(k-1:-1:k-lenOUT))/A(1);
    e(k) = w - y(k);
    if nP > 0 % u(k) závislé i na pøedchozích akèních zásazích (u)
        u(k) = (R*w - Q*y(k:-1:k-nQ) - P(2:end)*u(k-1:-1:k-nP))/P(1);
    else % u(k) závsilé jen na výstupech ze soustavy
        u(k) = (R*w - Q*y(k:-1:k-nQ))/P(1);
    end
    
end

lenOfData = N+lenOUT-1;

% posunutí jednu iteraci pøed poèátek zmìn u(k) (odøíznutí inicializaèních hodnot)
y = y(lenOUT:lenOfData);
e = e(lenOUT:lenOfData);
u = u(lenOUT:lenOfData);

figure(1)
    subplot(311)
        stairs(time,u)
            title('Akèní zásah == výstup z regulátoru')
            xlabel('iterace (k)')
            ylabel('u(k)')
            xlim([0,time(end)])
            grid on
    subplot(312)
        stairs(time,y)
            hold on
            title('Regulovaná velièina == výstup ze soustavy')
            xlabel('iterace (k)')
            ylabel('y(k)')
            xlim([0,time(end)])
            grid on
    subplot(313)
        stairs(time,e)
            title('Regulaèní odchylka == w(k) - y(k)')
            xlabel('iterace (k)')
            ylabel('e(k)')
            xlim([0,time(end)])
            grid on
        
%%
% figure(2)
%     step(c2d(tf(cit,jm),T,'zoh'))
%     hold on
%     plot(time,y,'-r')
     