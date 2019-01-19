function [B,A] = mnc(nb,na,y,u)
    
    Nrows = length(y) - na + 1;
    Ncols = nb + na - 1;

    % sestrojeni matice X
    X = zeros(Nrows,Ncols);
    
%     size(X)
%     X(1,:)
%     X(end,:)
     
    % naplneni matice X
    for i = 1:Nrows
          X(i,:) = [-y(i+na-2:-1:i)' u(i+nb-1:-1:i)'];
    end

%     size(X)
%     X(1,:)
%     X(end,:)
%     size(y(na:end))

    % vypocet koeficientu pomoci pseudoinverze matice X
    K = pinv(X)*y(na:end);
    
    % osamostatneni A a B
    A = [1; K(1:na-1)];
    B = K(na:end);