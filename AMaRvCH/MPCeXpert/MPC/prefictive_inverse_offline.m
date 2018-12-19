close all
clear

% PREDIKTIVNÍ REGULACE
ki = 1.31;
Tis = [30 45];
cit = ki;
jm = conv([Tis(1) 1],[Tis(2) 1]);
T = 1;
N = 600;
Navg = 5;  % z kolika hodnot udìlat prùmìr výstupu
time = 0:T:(N-1)*T;

% diskretizace
[B_sys,A_sys] = c2dm(cit,jm,T,'zoh');

% prevod na odchylkovy tvar (s integralnim charakterem):
delta = [1.0 -1.0]; % 1 - z^(-1)
AA_sys = conv(A_sys,delta);

% pocet parametru (pocet nenulovych elementu soustavy)
len_B = length(B_sys);      % delka vstupu (c)
len_A = length(AA_sys);     % delka vystupu (d)
delay = len_A - len_B;     % o kolik je rad jmenovatele vyssi nez rad citatele (zpozdeni)

%% Matice predikcniho modelu
N_pred = 100;

% matice budoucich vystupu
A_future = eye(N_pred);
for i = 2:N_pred % 2. az posledni radek
    if i >= len_A
        A_future(i,i-len_A+1:i-1) = AA_sys(end:-1:2); % naplneni spodnich radku, kde se A_sys neorezava
    else
        A_future(i,i:-1:1) = AA_sys(1:i); % naplneni hornich radku kde se A_sys orezava
    end
end

% matice budoucich akcnich zasahu
B_future = zeros(N_pred);
for i = 1:N_pred
    if i >= len_B
        B_future(i,i+1:-1:i+1-len_B+1) = B_sys;
    else
        B_future(i,i+1:-1:1) = B_sys(1:i+1);
    end
end

% odstraneni posledniho sloupce (ten uz tam nema byt)
B_future = B_future(:,1:end-1);

% matice minulych vystupu
A_past = zeros(N_pred,len_A-1);
for i = 1:len_A-1
   A_past(i,1:len_A-i) = -AA_sys(i+1:len_A);
end

% matice minulych akcnich zasahu
B_past = zeros(N_pred,len_B-1);
for i = 1:len_B-1
   B_past(i,1:len_B-i) = B_sys(i+1:len_B);
end

%% Regulacni zakon
lambda = 1;
G = A_future\B_future;
F = [A_future\B_past A_future\A_past];

% ridici velicina:
step_start = N_pred;
w = [ones(step_start,1)*0;ones(N/2,1)*6;ones(N/2,1)*2];

du_past = zeros(len_B-1,1);
u_past = zeros(len_B-1,1);
y_past = zeros(len_A-1,1);
h = [u_past;y_past];

du = zeros(N_pred,N);
u  = zeros(N_pred,1);
y = zeros(N,1);
e = zeros(N,1);

% odstraneni leading nul
B_sys = B_sys(find(B_sys,1,'first'):end);

% omezeni zmeny akcniho zasahu
u_max = 8;
u_min = 0;
lb = u_max*ones(N_pred,1); % dolni mez
ub = u_min*ones(N_pred,1); % horni mez

% potlaèení výstupu
options = optimset('Display', 'off');

% inicializace grafu
figure(1)
    xlabel('iterace (k)')
    ylabel('y,w,u (V)')
    grid on
    hold on

for k = len_A+1:N
    y(k) = (B_sys*u_past - A_sys(2:end)*y_past(1:end-1))/A_sys(1);
    
    % aktualizace minulosti vystupu
    y_past = [y(k);y_past(1:end-1)];
    h = [du_past;y_past];
    
    % vektory pro vypocet ucelove funkce
    H = G'*G + lambda*eye(size(G));
    j = G'*F*h - G'*w(k:k+N_pred-1); 
    
    % omezení akèních zásahù
    ub = [u_max - u(k-1); Inf(N_pred-1,1)];
    lb = [u_min - u(k-1); -Inf(N_pred-1,1)];
    
    % minimalizace ucelove funkce pomoci kvadratickeho programovaní
    du(:,k) = quadprog(2*H,j',[],[],[],[],lb,ub,[],options);
    
    % vypocet budoucich akcnich zasahu
    du_future = du(1,k);
        % vahy z budoucnosti
        
    % aktualizace akcnich zasahu
    du_past = [du_future(1);du_past(1:end-1)];
    u_past = u_past + du_past;
    
    h = [du_past;y_past];
    
    % ukladani akcnich zasahu
    u(k) = u_past(1);
    
    % vykreslení
    plot(time(k),y(k),'b.')
    plot(time(k),w(k),'r.')
    plot(time(k),u(k),'g.','MarkerEdgeColor',[0.3,0.5,0.2])
    drawnow
    pause(0.01)
end
hold off

%% finální graf
figure(2)
    plot(time,y,'-b','LineWidth',1.5);
    hold on
    plot(time,w(1:end-step_start),'-r','LineWidth',1.5);
    plot(time,u,'.','MarkerEdgeColor',[0.3,0.5,0.2])
    hold off
    title('Simulovaný regulaèní pochod')
    xlabel('iterace (k)')
    ylabel('y,w,u (V)')
    legend('y','w','u')
    grid on 
    grid minor
    axis tight
    
    % zmìna poøadí plotù
    ax = gca;
    axchld = ax.Children;
    set(gca,'Children',axchld(end:-1:1))
    
%% export dat
% export_fig(2,'./obrazky/final_simulovany.pdf')


