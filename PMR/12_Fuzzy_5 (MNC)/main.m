addpath ./fce
%%% Optimalizace hodnot výstupních signletonù fuzzy systému pomocí metody nejmenších ètvercù
%%% pro fitování vstupních hodnot
%% NASTAVITELNÉ PARAMETRY
n_mfs = 5;  % poèet fcí pøíslušnosti
mf_shape = 'gauss'; % 'gauss' pro gaussovské 'triang' pro trojúhelníkové

%% vygenerování vstupní funkce
x = (0:0.01:1)';
n_data = length(x);

y = (x-0.5).^3 + 0.5;

%% vygenerování vstupních funkcí pøíslušnosti
centers = linspace(min(x),max(x),n_mfs);
mfs = generate_mfs(centers,mf_shape);

%% vykreslení fcí pøíslušnosti na vstupním prostoru
if ishandle(1)
    delete(get(1,'Children'))
end
figure(1)
    hold on
    cellfun(@(mf) plot(x, mf(x)), mfs)
    title('funkce pøíslušnosti vstupního prostoru (x)')
    xlabel('x')
    ylabel('\mu(x)')
    grid on
    axis tight
    hold off
    
%% naplnìní matice levých stran (M)
mus = zeros(n_data,n_mfs);
M = zeros(size(mus));
for i = 1:n_data
    mus(i,:) = cellfun(@(mf) mf(x(i)) ,mfs); % matice pøíslušností
    M(i,:) = mus(i,:)/sum(mus(i,:));  % matice pøíslušností podìlená sumou
end

% vypocet ypar pomoci pseudoinverze matice M
ypar = pinv(M)*y;

%% inference
y_infer = zeros(n_data,1);
for i = 1:n_data
    y_infer(i) = mus(i,:)*ypar/sum(mus(i,:));
end

%% vykreslení
if ishandle(2)
    delete(get(2,'Children'))
end
figure(2)
    plot(x,y,x,y_infer)
    xlabel('x')
    ylabel('y')
    grid on
    legend('pùvodní funkce','fuzzy aproximace')
    title(sprintf('Fuzzy aproximace %u fcemi pøíslušnosti tvaru %s',n_mfs,mf_shape))
