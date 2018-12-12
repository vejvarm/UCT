close all
x = -10:0.1:10;

mi1 = gaussmf(x,[2,-2.5]);
mi2 = gaussmf(x,[2,2.5]);

%% Min pr�nik
tMAXmi = max(mi1,mi2);

%% Dombi pr�nik
lambdas = 1000;
tDOMBImi = arrayfun(@(lambda) 1./(1 + ((1./mi1 - 1).^lambda + (1./mi2 - 1).^lambda).^(1/lambda)), ...
                    lambdas,'UniformOutput',false);

figure(1)
    plot_mis(x,{mi1,mi2,tDOMBImi{1}},'Dombi pr�nik')
    
%% Dubois-Prade
alpha = 1;  % pro alpha = 1 == Algebraick� pr�nik == mi1.*mi2
tDUBOISmi = mi1.*mi2./(max(max(mi1,mi2),alpha));

figure(2)
	plot_mis(x,{mi1,mi2,tDUBOISmi},'Dubois-Prade')
    
%% Yager
w = 0.01;  % w in (0,inf) (pro w -> 0 se bl�� k Drastick�mu pr�niku)
tYAGERmi = 1 - min(1,((1-mi1).^w + (1-mi2).^w).^(1/w));

figure(3)
    plot_mis(x,{mi1,mi2,tYAGERmi},strcat('Yager�v pr�nik (w= ',num2str(w),')'))

%% Einstein
tEINSTEINmi = (mi1.*mi2)./(2 - (mi1 + mi2 - mi1.*mi2));

figure(4)
    plot_mis(x,{mi1,mi2,tEINSTEINmi},'Einstein�v pr�nik')

    
%% Drastick�
tDRASTICmi = (mi2 == 1).*mi1 + (mi1 == 1).*mi2;

figure(5)
    plot_mis(x,{mi1,mi2,tDRASTICmi},'Drastick� pr�nik')