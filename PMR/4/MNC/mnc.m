function [B,A] = mnc(nb,na,y,u)
    
    % sestrojeni matice X
    X = zeros(length(u)-na,nb + na - 1);

    % naplneni matice X
    for i = na:length(u)
        X(i,:) = [u(i:-1:i-nb+1)' -y(i-1:-1:i-na+1)'];
    end
    
    % vypocet koeficientu pomoci pseudoinverze matice X
    Xpinv = (X'*X)\X'; % == pinv(X)
    K = Xpinv*y;
    
    % osamostatneni B a A
    B = K(1:nb);
    A = [1; K(nb+1:end)];
    
    
    