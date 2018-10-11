syms p

V = 1;
C = 2;
tspan = [-1,1];

F = ((1-p)*V + p*(V-C)/2 - (1-p)*V/2)*p*(1-p);  % evoluèní tlak
dF = diff(F);   % derivace evoluèního tlaku (- ... stabilní, + ... nestabilní);
IF = -int(F);    % pøevrácená hodnota integrálu evoluèního tlaku == Synergický potenciál

figure(1)
    fplot(IF, tspan)
    hold on
    fplot(F, tspan)
    fplot(dF, tspan)
    grid on
    grid minor
    legend('V','F','dF')
    hold off