function M = plancks_law(lambdas, T, eta)
    % lambdas (nm) ... pole hodnot vlnových délek pro které zákon vypoèítat 
    % T (K) ... teplota èerného tìlesa
    % eta (1) ... spektrální emisivita šedého tìlesa
    % M.max ... maximální hodnota spektrální hustoty pøed normalizací
    % M.values ... normovaná hodnota spektrální hustoty na maximum 2^14
    
    if nargin == 2
        eta = 1.0;
    end
        
    k = 1.38064852e-23;  % Boltzmannova konstanta (J/K)
    h = 6.626070040e-34; % Planckova konstanta (Js)
    c = 299792458;       % Rychlost svìtla ve vakuu (m/s)
    
    % pøevod vlnových délek na metry
    lambdas = lambdas.*10^-9;
    
    % spektrální hustota vyzaøování pro jednotlivé vlnové délky
    C1 = (8*pi*h*c^2)./(lambdas.^5);
    C2 = h*c./(k*T.*lambdas);
    M0 = eta*C1.*(1./(exp(C2)-1));
    
    M.max = max(M0);
    
    % normalizace na maximum 2^14 (14 bitový AD pøevodník)
    M.values = M0/M.max*2^14;