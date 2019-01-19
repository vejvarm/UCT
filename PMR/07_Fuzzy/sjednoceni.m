x = -10:0.1:10;

mi1 = gaussmf(x,[2,-2.5]);
mi2 = gaussmf(x,[2,2.5]);

%% Max sjednocení
sMAXmi = max(mi1,mi2);

%% Dombi sjednocení
lambdas = 1000;
sDOMBImi = arrayfun(@(lambda) 1./(1 + ((1./mi1 - 1).^-lambda + (1./mi2 - 1).^-lambda).^(-1/lambda)), ...
                    lambdas,'UniformOutput',false);

figure(1)
    plot(x,mi1,x,mi2)
    hold on
    cellfun(@(s) plot(x,s), sDOMBImi);
    hold off
    legend(strcat('\lambda= ',num2str(lambdas(1))))
%% Dubois-Prade
alpha = 0.6;
sDUBOISmi = (mi1 + mi2 - mi1.*mi2 - min(min(mi1,mi2),1-alpha))./ ...
            max(max(1-mi1,1-mi2),alpha);

figure(2)
    plot(x,mi1,x,mi2)
    hold on
    plot(x,sDUBOISmi)
    hold off
    legend(strcat('\alpha= ',num2str(alpha)))
    
%% Einstein, Algebraické
sEINSTEINmi = (mi1 + mi2)./(1 + mi1.*mi2);
sALGEBmi = mi1 + mi2 - mi1.*mi2;

figure(3)
    plot(x,mi1,x,mi2)
    hold on
    plot(x,sEINSTEINmi)
    plot(x,sALGEBmi)
    hold off
    legend('a','b','Einstein(a,b)','Algeb(a,b)')
    
%% Drastické