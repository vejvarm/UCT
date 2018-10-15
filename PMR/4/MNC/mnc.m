function [B,A] = mnc(nb,na,y,u)
    
    % sestrojeni matice X
    X = zeros(length(u)-na,nb + na);
    
    for i = na:length(u)
        X(i-na+1,:) = [u(i:-1:i-nb)' y(i-1:-1:i-na+1)'];
    end
    
    X
    max(X'*X)
    min(X'*X)
    det(X'*X)
    eig(X'*X)
    
    % vypocet koeficientu
    K = (X'*X)\X'*y(na:end);
    
    % osamostatneni B a A
    B = K(1:nb);
    A = K(nb+1:end);
    
    
    