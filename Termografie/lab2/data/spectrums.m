close all
%% na?ten� dat
if ~exist('data','var')
    data = xlsread('BMT_Spektro.xlsx','List2');
end

%% rozd?len� dat
lambda = data(:,1);
temps = [1100+13,1050+14.5,1000+16,950+14,900+13]+273.15;  % sn�man� teploty v Kelvinech s p?id�n�m korekce
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
    subplot(311)
        plot(lambda,data(idx_min:idx_max,2:end))
        xlabel('\lambda (nm)')
        ylabel('M_\lambda (norm)')
        legend(leg)
        grid on
        grid minor
    
% %% Wien?v posunovac� z�kon
% b = 2.8977729e6; % Wienova konstanta (nm/K)
% 
% % nalezen� vlnov�ch d�lek p?i kter�ch doch�z� k max vyza?ov�n�
% [E_max, idx_max] = cellfun(@max, spectr{);
% 
% lambda_max = lambda(idx_max);
% 
% T = b./lambda_max;

%% Planck?v z�kon pro dan� teploty
lspan = lambda;
eta = 0.995; % emisivita inocelov� vlo�ky

M = cell(1,length(temps));

for i = 1:length(temps)
    M{i} = plancks_law(lspan, temps(i));
end

figure(1)
    subplot(312)
        hold on
        cellfun(@(M) plot(lspan,M), M)
        hold off
        xlabel('\lambda (nm)')
        ylabel('M_\lambda (norm)')
        legend(leg)
        grid on
        grid minor
    
%% fitov�n� p?enosov� funkce
coeff = cell(1,length(temps));
for i = 1:length(temps)
    coeff{i} = M{i}./spectr{i}.vals;
end

% ulo�en� koeficient? do .mat souboru
save('coeffs','coeff');

figure(1)
    subplot(313)
        hold on
        cellfun(@(coeff) plot(lambda,coeff), coeff)
        hold off
        legend(leg)
        grid on
        grid minor

%% pou�it� fitovac� funkce s koeficienty p?i teplot? 1100 �C
vals = fit_spectrum(M{1}, coeff{1});

figure(4)
    plot(lambda,vals)

%% na?ten� dat z m??en� spektra �haven�ho Wolframov�ho vl�kna
if ~exist('wolfram','var')
    wolfram = xlsread('BMT_Spektro.xlsx','List3','A18:B2065');
end

%% v�po?et spektra z p?enosov� funkce soustavy
eta_w = 0.05; % https://www.optotherm.com/emiss-table.htm
M_tf = transfer_func(wolfram(idx_min:idx_max,2), 1.0);

figure(5)
    plot(lambda, M_tf)
    hold on
    plot(lambda, plancks_law(lambda, 1800));
    
%% vytvo?en� funkce pro v�po?et spektra vystupuj�c�ho ze spektrometru
function M_spectr = fit_spectrum(M_planck, coeffs)
    M_spectr = M_planck./coeffs;
end

%% p?enosov� funkce m??�c�ho ?et?zce (spektrum -> Planck?v z�kon)
function M_tf = transfer_func(M_spectr, eta, coeffs)

    if nargin < 3
        S = load('coeffs.mat');
        coeffs = S.coeff{1};
    end

    if nargin < 2
        eta = 1.0;
    end

    M_tf = (M_spectr.*coeffs)/eta;
end


