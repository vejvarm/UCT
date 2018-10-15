close all
%% na�ten� dat
if ~exist('data','var')
    data = xlsread('BMT_Spektro.xlsx','List2');
end

%% rozd�len� dat
lambda = data(:,1);
temps = [1100+13,1050+14.5,1000+16,950+14,900+13]+273.15;  % sn�man� teploty v Kelvinech s p�id�n�m korekce
spectr = cell(1,length(temps));
leg = strings(1,length(temps));
for i = 1:length(temps)
    spectr{i}.temp = temps(i);
    spectr{i}.vals = data(:,i+1);
    leg(i) = strcat(num2str(temps(i)-273.15),' �C');
end

%% omezen� na interval (200,1050) nm
l_bounds = [200,1050];
[~, idx_min] = min(abs(lambda-l_bounds(1)));
[~, idx_max] = min(abs(lambda-l_bounds(2)));

lambda = lambda(idx_min:idx_max);
for i = 1:length(temps)
    spectr{i}.vals = spectr{i}.vals(idx_min:idx_max);
end

%% vykreslen� spekter
figure(1)
    sp(1) = subplot(311);
        plot(lambda,data(idx_min:idx_max,2:end))
        title('Nam��en� spektra')
        ylabel('M_{\lambda,spectr}')
        

%% Planck�v z�kon pro dan� teploty
lspan = lambda;
eta = 0.995; % emisivita inocelov� vlo�ky

M = cell(1,length(temps));

for i = 1:length(temps)
    M{i} = plancks_law(lspan, temps(i), eta);
end

% vykreslen� Planckova z�kona
figure(1)
    sp(2) = subplot(312);
        hold on
        cellfun(@(M) plot(lspan, M.values), M)
        hold off
        title('Planck�v vyza�ovac� z�kon')
        ylabel('M_\lambda (norm)')
    
%% v�po�et koeficient� p�enosov� funkce
coeff = cell(1,length(temps));
for i = 1:length(temps)
    coeff{i} = M{i}.values./spectr{i}.vals;
end

% ulo�en� koeficient� do .mat souboru
save('coeffs','coeff');

% vykreslen� koeficient�
figure(1)
    sp(3) = subplot(313);
        hold on
        cellfun(@(coeff) plot(lambda,coeff), coeff)
        hold off
        title('Koeficienty p�enosov� funkce')
        ylabel('coeff (1)')

%% nastaven� spole�n�ch vlastnost� subplot� ve figure(1)
set_properties(sp,leg)

%% vykreslen� koeficient� p�enosov� funkce p�i teplot� 1100
figure(2)
    plot(lambda,coeff{1})
    title('Koeficienty p�enosov� funkce p�i teplot� 1100 �C')
    set_properties(gca, strcat('coeff (',leg(1),')'))
    ylabel('coeff (1)')
    
%% na�ten� dat z m��en� spektra �haven�ho Wolframov�ho vl�kna
if ~exist('wolfram','var')
    wolfram = xlsread('BMT_Spektro.xlsx','List3','A18:B2065');
end

%% v�po�et spektra z p�enosov� funkce soustavy
eta_w = 0.37; % https://aip.scitation.org/doi/10.1063/1.1735847
Tspan = 1500:10:1550;
M_tf = fit_planck(wolfram(idx_min:idx_max,2), eta_w);
leg2 = strings(1,length(Tspan));
leg2(1) = 'M_{\lambda,Wolfram}';
% M_pl = plancks_law(lambda, 1510);

M_pl = cell(1,length(Tspan));

for i = 1:length(Tspan)
    M_pl{i} = plancks_law(lspan, Tspan(i), eta_w);
    leg2(i+1) = strcat('M_{\lambda,0} (',num2str(Tspan(i)),' �C)');
end

figure(3);
    plot(lambda, M_tf)
    hold on
    cellfun(@(M_pl) plot(lspan, M_pl.values), M_pl)
    hold off
    set_properties(gca,leg2)
    title('Fitov�n� p�eveden�ho spektra W na Planck�v z�kon')
    ylabel('M_\lambda (norm)')

%% Fitov�n� Planckova z�kona na spektrum
Sp_Wolf = wolfram(idx_min:idx_max,2);

figure(4);
    plot(lambda, Sp_Wolf, 'LineWidth',1.5)
    set_properties(gca,'Sp_{Wolfram} p�i P = 2,808 W')
    title('Spektr�ln� charakteristika �haven�ho W vl�kna')
    ylabel('Sp_\lambda')

Sp_0 = cell(1,length(Tspan));
leg3 = strings(1,length(Tspan)+1);
leg3(1) = 'Sp_{Wolfram}';

for i = 1:length(Tspan)
    Sp_0{i} = fit_spectrum(M_pl{i}.values, eta_w);
    leg3(i+1) = strcat('Sp_{0} (',num2str(Tspan(i)),' �C)');
end

figure(5);
    plot(lambda, Sp_Wolf, 'LineWidth',1.5)
    hold on
%     plot(lambda, fit_spectrum(M_pl{2}.values, eta_w))
    cellfun(@(Sp) plot(lspan, Sp, 'LineStyle','-'), Sp_0)
    hold off
    set_properties(gca,leg3)
    title('Fitov�n� Planckova z�kona na spektrum W dr�tku')
    ylabel('Sp_\lambda')
    
%% ulo�en� graf�
% save_fig(1,'M_Sp_coeff')
% save_fig(2,'coeff1113')
% save_fig(3,'fit_from1500to1550closeup')
% save_fig(4, 'wolfram')
% save_fig(5,'fitPltoWolfram1510')
    
%% funkce pro v�po�et spektra vystupuj�c�ho ze spektrometru
function Sp = fit_spectrum(M_planck, eta, coeffs)

    if nargin < 3
        S = load('coeffs.mat');
        coeffs = S.coeff{1};
    end

    if nargin < 2
        eta = 1.0;
    end

    Sp = eta*(M_planck./coeffs);
end

%% funkce pro v�po�et hodnot spektr�ln� hustoty intenzity vyza�ov�n� ze zadan�ho spektra
function M_planck = fit_planck(M_spectr, eta, coeffs)

    if nargin < 3
        S = load('coeffs.mat');
        coeffs = S.coeff{1};
    end

    if nargin < 2
        eta = 1.0;
    end

    M_planck = (M_spectr.*coeffs)/eta;
end

%% metoda pro nastaven� spole�n�ch vlastnost� graf�
function set_properties(hs,leg)
    arrayfun(@(hs) grid(hs,'on'), hs)
    arrayfun(@(hs) grid(hs,'minor'), hs)
    arrayfun(@(hs) xlabel(hs,'\lambda (nm)'), hs)
    arrayfun(@(hs) legend(hs,leg,'Location','northwest'), hs)
end

%% metoda pro ulo�en� grafu ve vektorov�m form�tu pdf
function save_fig(f,name)
    export_fig(f,strcat('.\img\',name,'.pdf'))
end



