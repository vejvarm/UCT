addpath ./fce

% -- VZORKOV�N� A �AS --
Ts = 1;
tmax = 1000;
tspan = 0:Ts:tmax;
N = length(tspan);

% -- SKUTE�N� SOUSTAVA --
ka = 1;
Ta = 10;
eps = 1;
B = ka;
A = [Ta^2 2*eps*Ta 1];
% A = [1 2 3 4];
[Bz,Az] = c2dm(B,A,Ts,'zoh');

% -- IDENTIFIKOVAN� SOUSTAVA --
nb = length(nonzeros(Bz));   % nb predchozich vstupu na prave strane (+1 aktualni pokud m = n)
na = length(Az);             % na-1 vystupu je na prave strane
delay = na - nb - 1;         % o kolik je rad jmenovatele vyssi nez rad citatele (zpozdeni)
init_ratio = 0.1;            % d�lka inicializa�n�ch dat jako pom�r celkov� d�lky dat

% -- POLE ASSIGNMENT REGUL�TOR --
% D = [1 -0.6 0.07];      % po�adovan� prav� strana
D = [1.0000 -0.5000 0.0625];      % po�adovan� prav� strana
rD = roots(D)
w = 1*ones(N,1);  % ��dic� veli�ina

%% INICIALIZACE
% pomocn� vektory
t = 0:Ts:(N-1)*Ts;
u = zeros(N,1); % u(1) = u(k) ; u(2) = u(k+1) ; u(3) = u(k+2); ...
y = zeros(N,1); % y(1) = y(k) ; y(2) = y(k+1) ; y(3) = y(k+2) ; ...
yi = zeros(N,1);
e = ones(N,1);

% Inicializace matic B, P a vektoru parametr� K (pro RMN�)
init_length = floor(init_ratio*N);  % d�lka inicializa�n�ch dat
u0 = ones(init_length,1);
yreal = nonlinSys(t(1:init_length)',u0);
y0 = yreal(1:init_length);
[Prmnc,Brmnc] = calcBandP(nb,na,y0,u0);
Krmnc = Prmnc*Brmnc;

% osamostatneni nul a p�l�
Bi = Krmnc(1:nb);
Ai = [1; Krmnc(nb+1:end)];


%% rozhodnut� o ��du polynom� P a Q:
nA = length(Az)-1;
nB = length(Bz)-1;
nD = length(D)-1;

if nA + nB > nD
    nQ = nA - 1;
else
    nQ = nD - nB - 1;
end

nP = nB - 1;

%% PR�B�H REGULA�N�HO POCHODU
% inicializace grafu
if ishandle(1)
    delete(get(1,'Children'))
end
figure(1)
%     plot(0,0,'b.',0,0,'r.')
%     hold on

% DEBUG
% Bz = Bz + 0.01;
% Az(2:end) = Az(2:end) - 0.01;

for k = na:N
    
    if delay == 0
        u(k) = u(k-1);
    end
    
    % Adaptivn� regulace
    % v�po�et parametr� modelu soustavy pomoc� RMN�
    % identifikace parametr� soustavy pomoc� RMN�
    if k > init_length
        [Prmnc,Krmnc] = rmnc(nb,na,y(k-na:k-1),u(k-nb-1:k-1),Prmnc,Krmnc);
    end
    
    % osamostatneni nul a p�l�
    if delay >= 0
        Bi = [zeros(delay+1,1); Krmnc(1:nb)];  % dopln�n� Bi nulami na stejnou d�lku jako Ai
    else
        Bi = Krmnc(1:nb);
    end
    Ai = [1; Krmnc(nb+1:end)];
    
    % v�po�et v�stupu modelu
    yi(k) = (Bi'*u(k-delay:-1:k-na+1) - Ai(2:end)'*yi(k-1:-1:k-na+1))/Ai(1);
    
    % v�po�et v�stupu re�ln� soustavy
%     y(k) = (Bz*u(k-delay:-1:k-na+1) - Az(2:end)*y(k-1:-1:k-na+1))/Az(1);
    y(k) = nonlinSys(t(k-1),u(k-1));
    e(k) = w(k) - y(k);
    
    % porovn�n� identifikovan� soustavy s re�lnou
    plot(t,y,'-b',t,yi,'-r','LineWidth',2);
    
    drawnow
    
    %% Sylvestrova matice pro vy�e�en� polynom� P a Q
    dims = nA + nB; % rozm�ry matice
    M = zeros(dims,dims);
    % napln�n� matice
    % 1. ��st (napln�n� polynomem A)
    for index = 1:nB
        M(index:index+nA,index) = Ai;
    end
    % 2. ��st (napln�n� polynomem B)
    for index = nB+1:dims
       M(index-nB:index,index) = Bi;
    end

    % vektor prav�ch stran:
    b = zeros(dims,1);
    b(1:nD+1) = D';

    % v�po�et soustavy rovnic
    PQ = M\b; % ekvivalent inv(M)*b

    % rozd�len� v�sledku do vektor� P a Q
    P = PQ(1:nP+1)';
    Q = PQ(nP+2:end)';
    
    %% v�po�et R
    R = sum(D)/sum(Bi); %R/D pro z = 1

    if nP > 0 % u(k) z�visl� i na p�edchoz�ch ak�n�ch z�saz�ch (u)
        u(k) = (R*w(k) - Q*y(k:-1:k-nQ) - P(2:end)*u(k-1:-1:k-nP))/P(1);
    else % u(k) z�vsil� jen na v�stupech ze soustavy
        u(k) = (R*w(k) - Q*y(k:-1:k-nQ))/P(1);
    end
    
end
hold off
legend('skute�n� soustava','identifikovan� soustava')

lenOfData = N+na-1-1;

% posunut� jednu iteraci p�ed po��tek zm�n u(k) (od��znut� inicializa�n�ch hodnot)
% y = y(na-1:lenOfData);
% e = e(na-1:lenOfData);
% u = u(na-1:lenOfData);


if ishandle(3)
    delete(get(3,'Children'))
end
figure(3)
    subplot(311)
        stairs(tspan,u)
            title('Ak�n� z�sah == v�stup z regul�toru')
            xlabel('iterace (k)')
            ylabel('u(k)')
            xlim([0,tspan(end)])
            grid on
    subplot(312)
        stairs(tspan,y)
            hold on
            title('Regulovan� veli�ina == v�stup ze soustavy')
            xlabel('iterace (k)')
            ylabel('y(k)')
            xlim([0,tspan(end)])
            grid on
    subplot(313)
        stairs(tspan,e)
            title('Regula�n� odchylka == w(k) - y(k)')
            xlabel('iterace (k)')
            ylabel('e(k)')
            xlim([0,tspan(end)])
            grid on
        
%%
% figure(2)
%     step(c2d(tf(cit,jm),T,'zoh'))
%     hold on
%     plot(time,y,'-r')

