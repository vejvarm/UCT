function M_norm = plancks_law(lambdas, T, eta)
    % lambdas (nm) ... pole hodnot vlnov�ch d�lek pro kter� z�kon vypo?�tat 
    % T (K) ... teplota ?ern�ho t?lesa
    % eta (1) ... spektr�ln� emisivita �ed�ho t?lesa
    % M_norm ... normovan� hodnota spektr�ln� hustoty na maximum 2^14
    
    if nargin == 2
        eta = 1.0;
    end
        
    k = 1.38064852e-23;  % Boltzmannova konstanta (J/K)
    h = 6.626070040e-34; % Planckova konstanta (Js)
    c = 299792458;       % Rychlost sv?tla ve vakuu (m/s)
    
    % p?evod vlnov�ch d�lek na metry
    lambdas = lambdas.*10^-9;
    
    % spektr�ln� hustota vyza?ov�n� pro jednotliv� vlnov� d�lky
    C1 = (8*pi*h*c^2)./(lambdas.^5);
    C2 = h*c./(k*T.*lambdas);
    M = eta*C1.*(1./(exp(C2)-1));
    
    % normalizace na maximum 2^14 (14 bitov� AD p?evodn�k)
    M_norm = M/max(M)*2^14;