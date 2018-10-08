function M_norm = plancks_law(lambdas, T, eta)
    % lambdas (nm) ... pole hodnot vlnových délek pro které zákon vypo?ítat 
    % T (K) ... teplota ?erného t?lesa
    % eta (1) ... spektrální emisivita šedého t?lesa
    % M_norm ... normovaná hodnota spektrální hustoty na maximum 2^14
    
    if nargin == 2
        eta = 1.0;
    end
        
    k = 1.38064852e-23;  % Boltzmannova konstanta (J/K)
    h = 6.626070040e-34; % Planckova konstanta (Js)
    c = 299792458;       % Rychlost sv?tla ve vakuu (m/s)
    
    % p?evod vlnových délek na metry
    lambdas = lambdas.*10^-9;
    
    % spektrální hustota vyza?ování pro jednotlivé vlnové délky
    C1 = (8*pi*h*c^2)./(lambdas.^5);
    C2 = h*c./(k*T.*lambdas);
    M = eta*C1.*(1./(exp(C2)-1));
    
    % normalizace na maximum 2^14 (14 bitový AD p?evodník)
    M_norm = M/max(M)*2^14;