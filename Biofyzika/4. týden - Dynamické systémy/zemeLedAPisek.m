syms T

eta = 0.2;
tspan = [-2,2];

S = eta - T^4;
dS = diff(S);
IS = -int(S);

figure(1)
    fplot(IS,tspan)
    hold on
    fplot(S,tspan)
    fplot(dS,tspan)
    hold off
    legend('V','S','IS')
    ylim([-1,1])