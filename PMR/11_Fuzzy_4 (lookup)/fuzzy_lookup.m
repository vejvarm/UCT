% close all
clear

%% mackey-glass
% parametry mackey-glass
alpha = 0.1;
beta = 0.2;
n = 9.65;
tau = 30;
% parametry vstupn�ch dat
N = 340;            % d�lka vstupn�ch dat

% % inicializace vstupn�ch dat
% x = zeros(N,1);     
% x(1:tau) = rand(tau,1);
% 
% % vypocet deterministicky chaotick�ch vstupn�ch dat Mackey-Glass rovnic�
% for k = tau+1:length(x)
%     x(k+1) = x(k) + beta*x(k-tau)/(1 + x(k-tau)^n) - alpha*x(k);
% end

x = mackey_glass(N, alpha, beta, tau, n);

% odstran�n� inicializa�n�ch dat
x = x(tau+1:end);
N = N - tau;

%% vykreslen� vstupn�ch dat
if ishandle(1)
    delete(get(1,'Children'))
end
figure(1)
    plot(x,'LineWidth',1.5)
    xlabel('k')
    ylabel('x')
    title('Tr�novac� �asov� �ada (Mackey-Glass)')
    grid on
    axis tight
    
%% fuzzy-lookup tabulka
% parametry fuzzy-lookup
n_mfs = 5;                 % po�et funkc� p��slu�nosti (mf) na vstupn�m prostoru (x)
n_ifs = 2;                  % po�et podm�nek v pravidlu
n_train = N-n_ifs+1;        % po�et tr�novac�ch dat
% M = 10;                   % po�et pravidel

% p��prava vstupn�ch/v�stupn�ch dat
Xs = zeros(N-n_ifs,n_ifs);   % vstupn� data
Ys = zeros(N-n_ifs,1);       % v�stupn� data
parfor i = 1:n_train
    Xs(i,:) = x(i:i+n_ifs-1);
    Ys(i) = x(i+n_ifs);
end

%% vygenerov�n� vstupn�ch gaussovsk�ch funkc� p��slu�nosti
gmfs = cell(n_mfs,1);
centers = linspace(min(x),max(x),n_mfs);
dcenters = mean(diff(centers));
parfor i = 1:n_mfs
    sig = gauss_sigma(centers(i) + dcenters/2,0.5,centers(i));
    gmfs{i} = @(xin) gaussmf(xin,[sig centers(i)]);  % gaussovky pravidel jako funkce 
end

% v�echny mo�n� n_ifs-permutace (variace) z gmfs (s opakov�n�m)
gmfs_perm = permn(gmfs,n_ifs);  % rozmery: (n_perm,n_ifs)
n_perm = size(gmfs_perm,1);     % po�et v�ech k-permutac� z n

%% vykreslen� gaussovsk�ch vstpn�ch funkc� p��slu�nosti
xspan = linspace(min(x),max(x),1000);

if ishandle(2)
    delete(get(2,'Children'))
end
figure(2)
    hold on
    cellfun(@(gmf) plot(xspan, gmf(xspan)), gmfs)
    title('funkce p��slu�nosti vstupn�ho prostoru (x)')
    xlabel('x')
    ylabel('\mu(x)')
    grid on
    axis tight
    hold off
    
%% v�po�et v�ech mo�n�ch kombinac� vstupn�ch gaussovek pro dan� v�stup
rules.mu_prod = cell(n_train,n_perm);
rules.y = cell(n_train,1);
% pro jednotliv� v�stupy
for idx_out = 1:n_train  % pro jednotliv� tr�novac� data (Xs(i,:),Ys(i))
    X = num2cell(Xs(idx_out,:));       % jeden ��dek tr�novac�ch dat
    for idx_perm = 1:n_perm  % pro jednotliv� permutace if ��st� pravidel
        perm = {gmfs_perm{idx_perm,:}};     % jedna permutace if ��sti (mf funkc�)
        % v�po�et pravidel pro v�echny vstupy, pro v�echny permutace if ��st�
        rules.mu_prod{idx_out,idx_perm} = prod(cellfun(@(perm,X) perm(X), perm,X));
        rules.y{idx_out} = Ys(idx_out);
    end
    % nalezen� nejlep�� (nejvy��� p��slu�nost) permutace if ��st� pro ka�d� v�stup
    [rules.best.val{idx_out}, rules.best.idx{idx_out}] = max([rules.mu_prod{idx_out,:}]);
end

% nalezen� unik�tn�ch hodnot
[unique_idxs, unique_vals, unique_ys] = best_unique(rules.best.idx, rules.best.val, rules.y);
rules.best.mfs = arrayfun(@(idx) {gmfs_perm{idx,:}}, unique_idxs, 'UniformOutput', false);  % nejlep�� unik�tn� pravidla
rules.best.ys = unique_ys;  % v�stupy nejlep��ch unik�tn�ch pravidel
% mu_prod = cell2mat(rules.mu_prod); % TODO: najdi maximum v ka�d�m ��dku (odpov�d� nejlep�� kombinaci MF pro predikci)


%% testov�n� predikce s nalezen�mi pravidly
% generov�n� testovac�ch dat
% inicializace vstupn�ch dat
N_test = 530;
alpha_test = alpha;
beta_test = beta;
tau_test = tau;
n_test = n;

% vygenerov�n� testovac�ch hodnot
x_test = mackey_glass(N_test, alpha_test, beta_test, tau_test, n_test);

x_test = x_test(tau+1:end);
N_test = N_test - tau;

% jednokrokov� predikce fuzzy syst�mem
fx = fuzzy_inference(x_test, rules.best.mfs, rules.best.ys);

% v�po�et chyby
err = abs(fx' - x_test(n_ifs:end));
s = sumsqr(fx' - x_test(n_ifs:end));

% vykreslen� testovac�ch v�sledk�
if ishandle(3)
   delete(get(3,'Children')) 
end
figure(3)
    set(3,'DefaultlineLineWidth',1.5)
    plot(x_test)
    hold on
    plot(n_ifs:N_test+1,fx)
    plot(n_ifs:N_test+1,err)
    title(strcat('Jednokrokov� predikce testovac� �asov� �ady (sumsqr= ',num2str(s),')'));
    legend('Mackey-Glass','Mackey-Glass (pred.)','abs. error')
    xlabel('k')
    ylabel('x')
    grid on
    axis tight
    hold off

%% ulo�en� grafu
% folder = './figs/';
% name = sprintf('nmfs%u_nifs%u.pdf',n_mfs,n_ifs);
% export_fig(3,strcat(folder,name));

%% EXPERIMENT: v�cekrokov� predikce (predikce z predikovan�ch hodnot)
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
% % vykreslen� testovac�ch v�sledk�
% if ishandle(4)
%    delete(get(4,'Children')) 
% end
% figure(4)
%     set(4,'DefaultlineLineWidth',1.5)
%     plot(x_test)
%     hold on
%     plot(x_multi)
%     plot(err_multi)
%     title(strcat('V�cekrokov� predikce testovac� �asov� �ady (sumsqr= ',num2str(s_multi),')'));
%     legend('Mackey-Glass','Mackey-Glass (pred.)','abs. error')
%     xlabel('k')
%     ylabel('x')
%     grid on
%     axis tight
%     hold off
