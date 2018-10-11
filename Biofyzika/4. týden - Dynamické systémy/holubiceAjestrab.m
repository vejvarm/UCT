syms p

V = 1;
C = 2;
tspan = [-1,1];

F = ((1-p)*V + p*(V-C)/2 - (1-p)*V/2)*p*(1-p);  % evolu�n� tlak
dF = diff(F);   % derivace evolu�n�ho tlaku (- ... stabiln�, + ... nestabiln�);
IF = -int(F);    % p�evr�cen� hodnota integr�lu evolu�n�ho tlaku == Synergick� potenci�l

figure(1)
    fplot(IF, tspan)
    hold on
    fplot(F, tspan)
    fplot(dF, tspan)
    grid on
    grid minor
    legend('V','F','dF')
    hold off