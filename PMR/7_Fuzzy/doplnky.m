x = -10:0.1:10;

mi = gaussmf(x,[2,0]);

%% Sugeno doplnìk
lambdas = -1:1:10;
cSmi = arrayfun(@(lambda) (1 - mi)./(1 + lambda*mi), lambdas,'UniformOutput',false);

figure(1)
    plot(x,mi)
    hold on
    cellfun(@(c) plot(x,c), cSmi);
    hold off
    legend(strcat('\lambda= ',num2str(lambda)))
    
%% Yager doplnìk
w = 0.6;
cWmi = (1 - mi.^w).^(1/w);

figure(2)
    plot(x,mi,x,cWmi);
    legend(strcat('w= ',num2str(w)))