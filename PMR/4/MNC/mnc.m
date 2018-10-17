function [B,A] = mnc(nb,na,y,u)
    
    % sestrojeni matice X
    X = zeros(length(u)-na,nb + na - 1);
%     X = zeros(nb+na);

    for i = na:length(u)
        X(i,:) = [u(i:-1:i-nb+1)' -y(i-1:-1:i-na+1)'];
    end
    
    length(u(i:-1:i-nb))
    length(y(i-1:-1:i-na+1))
%     X
    
    % vypocet koeficientu
    K = (X'*X)\X'*y;
%     K = pinv(X)*y(na:end);
%     K = y(na:end)*pinv(X);
%     K = lsqminnorm(X,y(na:end),'warn');
    
    % osamostatneni B a A
    B = K(1:nb);
    A = [1; K(nb+1:end)];
    
    
    