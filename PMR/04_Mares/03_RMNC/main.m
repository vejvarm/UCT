%% Rekurentn� metoda nejmen��ch �tverc�
%% d�le�it� parametry
% -- VZORKOV�N� A �AS --
Ts = 5;
tmax = 1000;
tspan = 0:Ts:tmax;
Nt = length(tspan);

% --- VSTUPN� SIGN�L ---
% u = linspace(0,1,Nt)';
% u = ones(Nt,1);
u = [linspace(0,1,floor(Nt/2))'; ones(ceil(Nt/2),1)];
% u = rand(Nt,1);

% -- SKUTE�N� SOUSTAVA --
ka = 5;
Ta = 20;
eps = 0.1;
B = ka;
A = [Ta^2 2*eps*Ta 1];
[Bz,Az] = c2dm(B,A,Ts);

% -- IDENTIFIKOVAN� SOUSTAVA --
nb = length(nonzeros(Bz));
na = length(Az);
init_ratio = 0.1;  % z jak� ��sti dostupn�ch dat se bude prov�d�t inicializace matic B a P (B0,P0)

%% diskr�tn� p�enos skute�n� soustavy
Fz = tf(Bz,Az,Ts);

% odezva skute�n� soustavy na specificky vstupn� signal u v �asech tspan
y = lsim(Fz,u,tspan);
    
%% vykreslen� odezvy simulovan� soustavy
figure(1)
    subplot(211)
    stairs(tspan,y)
    hold on
    stairs(tspan,u)
    hold off
    title('Skute�n� soustava')
    xlabel('�as (s)')
    ylabel('y,u')
    legend('odezva soustavy (y)','vstupn� sign�l (u)')
     
%% inicializace identifikace
% inicializace matic B a P (B0,P0)
init_length = floor(init_ratio*length(y));  % d�lka inicializa�n�ch dat
u0 = u(1:init_length);
y0 = y(1:init_length);
[P,B] = calcBandP(nb,na,y0,u0);
% B = ones(size(B));
% P = 0.2*rand(size(P));
K = P*B;

%% Testov�n� (m�rn� �prava parametr� re�ln� soustavy)
% simulace re�ln� soustavy s m�rnou �pravou parametr�
Bz_new = Bz - 0.01;
Az_new = Az - [0,0.03,-0.03];
Fz = tf(Bz_new,Az_new,Ts);
y = lsim(Fz,u,tspan);

%% identifikace pomoc� RMN�
figure(1)
    subplot(212)
for i = init_length:length(y)-na
    % identifikace parametr� pomoc� RMN�
    [P,K] = rmnc(nb,na,y(i:i+na-1),u(i:i+nb),P,K);
    
    % osamostatneni nul a p�l�
    Bi = K(1:nb);
    Ai = [1; K(nb+1:end)];
    
    % simulace soustavy s identifikovan�mi parametry
    Fzi = tf(Bi',Ai',Ts);
    yi = lsim(Fzi,u,tspan);
    
    % vykreslen� identifikovan� soustavy
    plot(tspan,y,tspan,yi,tspan(1:i),yi(1:i));
    drawnow
end
    title('Identifikovan� soustava')
    xlabel('�as (s)')
    ylabel('yi')

% suma �tverc� odchylek
R = sumsqr(yi - y);

%% vykreslen� posledn�ch identifikovan�ch parametr�
figure(2)
    set(2,'DefaultlineLineWidth',2)
    plot(tspan,y,'-b',tspan,yi,'-.r')
    xlabel('�as (s)')
    ylabel('y')
    title(sprintf('Porovn�n� skute�n� a identifikovan� soustavy (R = %.2f)',R))
    legend('odezva skute�n� soustavy','odezva identifikovan� soustavy')

