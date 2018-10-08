close all
%% na?tení dat
if ~exist('data','var')
    data = xlsread('BMT_Spektro.xlsx','List2');
end

%% rozd?lení dat
lambda = data(:,1);
temps = [1100+13,1050+14.5,1000+16,950+14,900+13]+273.15;  % snímané teploty v Kelvinech s p?idáním korekce
spectr = cell(1,length(temps));
leg = strings(1,length(temps));
for i = 1:length(temps)
    spectr{i}.temp = temps(i);
    spectr{i}.vals = data(:,i+1);
    leg(i) = strcat(num2str(temps(i)-273.15),' °C');
end

%% omezení na interval (200,1050) nm
l_bounds = [200,1050];
[~, idx_min] = min(abs(lambda-l_bounds(1)));
[~, idx_max] = min(abs(lambda-l_bounds(2)));

lambda = lambda(idx_min:idx_max);
for i = 1:length(temps)
    spectr{i}.vals = spectr{i}.vals(idx_min:idx_max);
end

%% vykreslení spekter
figure(1)
    subplot(311)
        plot(lambda,data(idx_min:idx_max,2:end))
        xlabel('\lambda (nm)')
        ylabel('M_\lambda (norm)')
        legend(leg)
        grid on
        grid minor
    
% %% Wien?v posunovací zákon
% b = 2.8977729e6; % Wienova konstanta (nm/K)
% 
% % nalezení vlnových délek p?i kterých dochází k max vyza?ování
% [E_max, idx_max] = cellfun(@max, spectr{);
% 
% lambda_max = lambda(idx_max);
% 
% T = b./lambda_max;

%% Planck?v zákon pro dané teploty
lspan = lambda;
eta = 0.995; % emisivita inocelové vložky

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
    
%% fitování p?enosové funkce
coeff = cell(1,length(temps));
for i = 1:length(temps)
    coeff{i} = M{i}./spectr{i}.vals;
end

% uložení koeficient? do .mat souboru
save('coeffs','coeff');

figure(1)
    subplot(313)
        hold on
        cellfun(@(coeff) plot(lambda,coeff), coeff)
        hold off
        legend(leg)
        grid on
        grid minor

%% použití fitovací funkce s koeficienty p?i teplot? 1100 °C
vals = fit_spectrum(M{1}, coeff{1});

figure(4)
    plot(lambda,vals)

%% na?tení dat z m??ení spektra žhaveného Wolframového vlákna
if ~exist('wolfram','var')
    wolfram = xlsread('BMT_Spektro.xlsx','List3','A18:B2065');
end

%% výpo?et spektra z p?enosové funkce soustavy
eta_w = 0.05; % https://www.optotherm.com/emiss-table.htm
M_tf = transfer_func(wolfram(idx_min:idx_max,2), 1.0);

figure(5)
    plot(lambda, M_tf)
    hold on
    plot(lambda, plancks_law(lambda, 1800));
    
%% vytvo?ení funkce pro výpo?et spektra vystupujícího ze spektrometru
function M_spectr = fit_spectrum(M_planck, coeffs)
    M_spectr = M_planck./coeffs;
end

%% p?enosová funkce m??ícího ?et?zce (spektrum -> Planck?v zákon)
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


