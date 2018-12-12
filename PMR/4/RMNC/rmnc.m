function [num,den] = rmnc(nb,na,y,u,B0,P0)

    persistent B P K
    
    % TODO: inicializace B a P pøi první, zavolání funkce
    if nargin == 6
        % inicializace B a P z matice X0
        B = B0;
        P = P0;
        K = B0*P0;
    end
            
    % sestrojeni vektoru x(k+1)
    x = [u(nb:-1:1)', -y(na-1:-1:1)'];
    
    % aktualizace B
    B = B + x'*y;
    
    % chyba predikce
    e = y - x*K;
    
    % vypocet m(k+1)
    m = P*x'./(1 + x*P*x');
    
    % aktualizace P
    P = P - m*x*P;
    
    % oprava odhadu parametrù
    K = K + m*e;
    
    % osamostatneni nul a pólù
    num = K(1:nb);
    den = [1; K(nb+1:end)];
    
    
    