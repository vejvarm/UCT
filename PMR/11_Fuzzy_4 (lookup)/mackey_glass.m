function x = mackey_glass(N, alpha, beta, tau, n, seed)
    
    % aplikace seedu
    if nargin == 6
       rng(seed) 
    end
    
    % inicializace
    x = zeros(N,1);     
    x(1:tau) = rand(tau,1);

    % vypocet deterministicky chaotických testovacích dat Mackey-Glass rovnicí
    for k = tau+1:length(x)
        x(k+1) = x(k) + beta*x(k-tau)/(1 + x(k-tau)^n) - alpha*x(k);
    end
end
    