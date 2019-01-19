function [num,den,Bout,Pout,Kout] = rmnc(nb,na,y,u,Bin,Pin,Kin)
    
%     K = Bin*Pin;
            
    % sestrojeni vektoru x(k+1)
    x = [u(nb:-1:1)', -y(na-1:-1:1)'];
    
    % aktualizace B
    Bout = Bin + x*y(end);
    
    % chyba predikce
    e = y(end) - x*Kin;
    
    % vypocet m(k+1)
    m = x*Pin/(1 + x*Pin*x');
    
    % aktualizace P
    Pout = Pin - m*x'*Pin;
    
    % oprava odhadu parametrù
    Kout = Kin + m'*e;
    

