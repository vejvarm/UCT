function [B,P] = calcBandP(nb,na,y,u)
    
    % sestrojeni matice X
    X = zeros(length(u)-na,nb + na - 1);

    % naplneni matice X
    for i = na:length(u)
        X(i,:) = [u(i:-1:i-nb+1)' -y(i-1:-1:i-na+1)'];
    end
    
    % vypocet matice B a vektoru P
    B = inv(X'*X); 
    P = X'*y;