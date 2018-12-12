addpath ./fce
%%% Optimalizace hodnot v�stupn�ch signleton� fuzzy syst�mu pomoc� metody nejmen��ch �tverc�
%%% pro fitov�n� vstupn�ch hodnot
%% NASTAVITELN� PARAMETRY
n_mfs = 5;  % po�et fc� p��slu�nosti
mf_shape = 'gauss'; % 'gauss' pro gaussovsk� 'triang' pro troj�heln�kov�

%% vygenerov�n� vstupn� funkce
x = (0:0.01:1)';
n_data = length(x);

y = (x-0.5).^3 + 0.5;

%% vygenerov�n� vstupn�ch funkc� p��slu�nosti
centers = linspace(min(x),max(x),n_mfs);
mfs = generate_mfs(centers,mf_shape);

%% vykreslen� fc� p��slu�nosti na vstupn�m prostoru
if ishandle(1)
    delete(get(1,'Children'))
end
figure(1)
    hold on
    cellfun(@(mf) plot(x, mf(x)), mfs)
    title('funkce p��slu�nosti vstupn�ho prostoru (x)')
    xlabel('x')
    ylabel('\mu(x)')
    grid on
    axis tight
    hold off
    
%% napln�n� matice lev�ch stran (M)
mus = zeros(n_data,n_mfs);
M = zeros(size(mus));
for i = 1:n_data
    mus(i,:) = cellfun(@(mf) mf(x(i)) ,mfs); % matice p��slu�nost�
    M(i,:) = mus(i,:)/sum(mus(i,:));  % matice p��slu�nost� pod�len� sumou
end

% vypocet ypar pomoci pseudoinverze matice M
ypar = pinv(M)*y;

%% inference
y_infer = zeros(n_data,1);
for i = 1:n_data
    y_infer(i) = mus(i,:)*ypar/sum(mus(i,:));
end

%% vykreslen�
if ishandle(2)
    delete(get(2,'Children'))
end
figure(2)
    plot(x,y,x,y_infer)
    xlabel('x')
    ylabel('y')
    grid on
    legend('p�vodn� funkce','fuzzy aproximace')
    title(sprintf('Fuzzy aproximace %u fcemi p��slu�nosti tvaru %s',n_mfs,mf_shape))
