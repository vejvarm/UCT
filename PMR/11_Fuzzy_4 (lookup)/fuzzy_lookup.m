% close all
clear

%% mackey-glass
% parametry mackey-glass
alpha = 0.1;
beta = 0.2;
n = 9.65;
tau = 30;
% parametry vstupních dat
N = 340;            % délka vstupních dat

% % inicializace vstupních dat
% x = zeros(N,1);     
% x(1:tau) = rand(tau,1);
% 
% % vypocet deterministicky chaotických vstupních dat Mackey-Glass rovnicí
% for k = tau+1:length(x)
%     x(k+1) = x(k) + beta*x(k-tau)/(1 + x(k-tau)^n) - alpha*x(k);
% end

x = mackey_glass(N, alpha, beta, tau, n);

% odstranìní inicializaèních dat
x = x(tau+1:end);
N = N - tau;

%% vykreslení vstupních dat
if ishandle(1)
    delete(get(1,'Children'))
end
figure(1)
    plot(x,'LineWidth',1.5)
    xlabel('k')
    ylabel('x')
    title('Trénovací èasová øada (Mackey-Glass)')
    grid on
    axis tight
    
%% fuzzy-lookup tabulka
% parametry fuzzy-lookup
n_mfs = 5;                 % poèet funkcí pøíslušnosti (mf) na vstupním prostoru (x)
n_ifs = 2;                  % poèet podmínek v pravidlu
n_train = N-n_ifs+1;        % poèet trénovacích dat
% M = 10;                   % poèet pravidel

% pøíprava vstupních/výstupních dat
Xs = zeros(N-n_ifs,n_ifs);   % vstupní data
Ys = zeros(N-n_ifs,1);       % výstupní data
parfor i = 1:n_train
    Xs(i,:) = x(i:i+n_ifs-1);
    Ys(i) = x(i+n_ifs);
end

%% vygenerování vstupních gaussovských funkcí pøíslušnosti
gmfs = cell(n_mfs,1);
centers = linspace(min(x),max(x),n_mfs);
dcenters = mean(diff(centers));
parfor i = 1:n_mfs
    sig = gauss_sigma(centers(i) + dcenters/2,0.5,centers(i));
    gmfs{i} = @(xin) gaussmf(xin,[sig centers(i)]);  % gaussovky pravidel jako funkce 
end

% všechny možné n_ifs-permutace (variace) z gmfs (s opakováním)
gmfs_perm = permn(gmfs,n_ifs);  % rozmery: (n_perm,n_ifs)
n_perm = size(gmfs_perm,1);     % poèet všech k-permutací z n

%% vykreslení gaussovských vstpních funkcí pøíslušnosti
xspan = linspace(min(x),max(x),1000);

if ishandle(2)
    delete(get(2,'Children'))
end
figure(2)
    hold on
    cellfun(@(gmf) plot(xspan, gmf(xspan)), gmfs)
    title('funkce pøíslušnosti vstupního prostoru (x)')
    xlabel('x')
    ylabel('\mu(x)')
    grid on
    axis tight
    hold off
    
%% výpoèet všech možných kombinací vstupních gaussovek pro daný výstup
rules.mu_prod = cell(n_train,n_perm);
rules.y = cell(n_train,1);
% pro jednotlivé výstupy
for idx_out = 1:n_train  % pro jednotlivá trénovací data (Xs(i,:),Ys(i))
    X = num2cell(Xs(idx_out,:));       % jeden øádek trénovacích dat
    for idx_perm = 1:n_perm  % pro jednotlivé permutace if èástí pravidel
        perm = {gmfs_perm{idx_perm,:}};     % jedna permutace if èásti (mf funkcí)
        % výpoèet pravidel pro všechny vstupy, pro všechny permutace if èástí
        rules.mu_prod{idx_out,idx_perm} = prod(cellfun(@(perm,X) perm(X), perm,X));
        rules.y{idx_out} = Ys(idx_out);
    end
    % nalezení nejlepší (nejvyšší pøíslušnost) permutace if èástí pro každý výstup
    [rules.best.val{idx_out}, rules.best.idx{idx_out}] = max([rules.mu_prod{idx_out,:}]);
end

% nalezení unikátních hodnot
[unique_idxs, unique_vals, unique_ys] = best_unique(rules.best.idx, rules.best.val, rules.y);
rules.best.mfs = arrayfun(@(idx) {gmfs_perm{idx,:}}, unique_idxs, 'UniformOutput', false);  % nejlepší unikátní pravidla
rules.best.ys = unique_ys;  % výstupy nejlepších unikátních pravidel
% mu_prod = cell2mat(rules.mu_prod); % TODO: najdi maximum v každém øádku (odpovídá nejlepší kombinaci MF pro predikci)


%% testování predikce s nalezenými pravidly
% generování testovacích dat
% inicializace vstupních dat
N_test = 530;
alpha_test = alpha;
beta_test = beta;
tau_test = tau;
n_test = n;

% vygenerování testovacích hodnot
x_test = mackey_glass(N_test, alpha_test, beta_test, tau_test, n_test);

x_test = x_test(tau+1:end);
N_test = N_test - tau;

% jednokroková predikce fuzzy systémem
fx = fuzzy_inference(x_test, rules.best.mfs, rules.best.ys);

% výpoèet chyby
err = abs(fx' - x_test(n_ifs:end));
s = sumsqr(fx' - x_test(n_ifs:end));

% vykreslení testovacích výsledkù
if ishandle(3)
   delete(get(3,'Children')) 
end
figure(3)
    set(3,'DefaultlineLineWidth',1.5)
    plot(x_test)
    hold on
    plot(n_ifs:N_test+1,fx)
    plot(n_ifs:N_test+1,err)
    title(strcat('Jednokroková predikce testovací èasové øady (sumsqr= ',num2str(s),')'));
    legend('Mackey-Glass','Mackey-Glass (pred.)','abs. error')
    xlabel('k')
    ylabel('x')
    grid on
    axis tight
    hold off

%% uložení grafu
% folder = './figs/';
% name = sprintf('nmfs%u_nifs%u.pdf',n_mfs,n_ifs);
% export_fig(3,strcat(folder,name));

%% EXPERIMENT: vícekroková predikce (predikce z predikovaných hodnot)
% N_multi = N_test;
% x_multi = x_test(1:n_ifs);
% 
% for i = n_ifs+1:N_multi+1
%     x_multi(i) = fuzzy_inference(x_multi(i-n_ifs:i-1), rules.best.mfs, rules.best.ys);
% end
% 
% err_multi = abs(x_multi - x_test);
% s_multi = sqrerr(x_multi - x_test);
% 
% % vykreslení testovacích výsledkù
% if ishandle(4)
%    delete(get(4,'Children')) 
% end
% figure(4)
%     set(4,'DefaultlineLineWidth',1.5)
%     plot(x_test)
%     hold on
%     plot(x_multi)
%     plot(err_multi)
%     title(strcat('Vícekroková predikce testovací èasové øady (sumsqr= ',num2str(s_multi),')'));
%     legend('Mackey-Glass','Mackey-Glass (pred.)','abs. error')
%     xlabel('k')
%     ylabel('x')
%     grid on
%     axis tight
%     hold off
