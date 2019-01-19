function [Pout,Kout] = rmnc(nb,na,y,u,Pin,Kin)
            
    % sestrojeni vektoru x(k+1)
    x = [u(nb:-1:1)', -y(na-1:-1:1)'];
    
    % chyba predikce
    e = y(end) - x*Kin;
    
    % vypocet m(k+1)
    m = Pin*x'/(1 + x*Pin*x');
    
    % aktualizace P
    Pout = Pin - m*x*Pin;
    
    % oprava odhadu parametrù
    Kout = Kin + m*e;
