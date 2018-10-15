clear
close all
% GAIN Scheduling:

% syms u s r0 t
% 
% y = 0.1/(u-1);
% dy = diff(y);
% 
% figure(1)
%     fplot(u,y)
%     hold on
%     fplot(u,dy)
%     hold off
%     ylim([-10,10])
%     
% %%
% Ks = -1/(10*(u - 1)^2);  % zesílení soustavy (záporné)
% T = 3; % èasová konstanta soustavy (trojnásobná)
% 
% Fs = Ks/(T*s + 1)^3;
% 
% rk = 0.1/((u-1)^2); % kritické zesílení soustavy (-Ks)
% 
% r0 = 0.6*rk;

%% hlavní smyèka (regulace)
tspan = [0 0 0:0.1:15000];
N = length(tspan);
len_part = round(N/3);

% inicializace promìnných
u = zeros(N,1); % u(1) = u(k) ; u(2) = u(k+1) ; u(3) = u(k+2); ...
y = 0*ones(N,1); % y(1) = y(k) ; y(2) = y(k+1) ; y(3) = y(k+2) ; ...
e = ones(N,1);
r0 = zeros(N,1);

% ridici velicina
ws = [0.1, 0.4, 0.2, 0.3];
N_ws = length(ws);
w = zeros(1,N);
for i = 1:N_ws
    start = floor((i-1)*N/N_ws) + 1;
    stop = floor(i*N/N_ws) + 1;
    w(start:stop-1) = ws(i)*ones(stop - start,1);
end
T = 0.1; % èasová konstanta regulátoru

for k = 3:N
   
    % výstup soustavy
    y(k) = Fs(tspan(k),u(k-1), y(1));
    
    % gain scheduling (aktualizace konstant regulátoru)
    [r0(k), Ti, Td] = gain(u(k-1));
    
%     Ti = 200;
    Td = 0;
    
    % pomocné výpoèty regulátoru
    q0 = -r0(k)*(1 + T/2/Ti+Td/T);
    q1 = r0(k)*(1 - T/2/Ti + 2*Td/T);
    q2 = -r0(k)*Td/T;
    
    % diskrétní PID regulátor
    u(k) = u(k-1) - (q0 + q1 + q2)*w(k)+ q0*y(k) + q1*y(k-1) + q2*y(k-2);
    
    e(k) = w(k) - y(k);
    
end

%% vykreslení
figure(1)
    sp(1) = subplot(211);
        plot(tspan,y)
        hold on
        plot(tspan,w)
        hold off
        ylabel('y, w (1)')
        legend('y', 'w')
    sp(2) = subplot(212);
        plot(tspan,u)
        hold on
        plot(tspan,r0)
        hold off
        ylabel('u, r0 (1)')
        legend('u', 'r0')
        
    arrayfun(@(spi) xlabel(spi, 'èas (s)'), sp)
    arrayfun(@(spi) grid(spi, 'on'), sp)
    arrayfun(@(spi) grid(spi, 'minor'), sp)