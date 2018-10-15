%% týden 2: Úkol 2
clear all
close all

%% vstupy
cit = [1.5];
jm = [5 5 1];
% cit = [3 4 1];
% jm = [5 3 3];
T = 1;
N = 500;
time = 0:T:(N-1)*T;

% w = 2; % øídicí velièina
w = [ones(300,1)*2;ones((600-300),1)*5];

% diskretizace
[B,A] = c2dm(cit,jm,T,'zoh');

% odstraneni nul
B = nonzeros(B); % vrati sloupcovy vektor
B = B';

% pocet parametru (pocet nenulovych elementu)
lenIN = length(B) - 1;      % lenIN predchozich vstupu na prave strane (+1 aktualni pokud m = n)
lenOUT = length(A) - 1;     % lenOUT vystupu je na prave strane
delay = lenOUT - lenIN;     % o kolik je rad jmenovatele vyssi nez rad citatele (zpozdeni)

% inicializace promìnných
u = zeros(N+lenOUT,1); % u(1) = u(k) ; u(2) = u(k+1) ; u(3) = u(k+2); ...
y = zeros(N+lenOUT,1); % y(1) = y(k) ; y(2) = y(k+1) ; y(3) = y(k+2) ; ...
e = ones(N+lenOUT,1);

%% Regulátor
r0 = 2.2414;
TI = 11.5;
TD = 2.875;
% r0 = 2.2;
% TI = 1;
% TD = 1;

% pomocne vypocty pro regulator
q0 = -r0*(1 + T/2/TI+TD/T);
q1 = r0*(1 - T/2/TI + 2*TD/T);
q2 = -r0*TD/T;

%% prùbìh regulaèního pochodu
for k = 1+lenOUT:N+lenOUT

    if delay == 0
        u(k) = u(k-1);
    end
    
    y(k) = (B*u(k-delay:-1:k-lenOUT) - A(2:end)*y(k-1:-1:k-lenOUT))/A(1);
    e(k) = w(k) - y(k);
    u(k) = u(k-1) - (q0 + q1 + q2)*w(k)+ q0*y(k) + q1*y(k-1) + q2*y(k-2);
    
end

%
lenOfData = N+lenOUT-1;

% posunutí jednu iteraci pøed poèátek zmìn u(k) (odøíznutí inicializaèních hodnot)
y = y(lenOUT:lenOfData);
e = e(lenOUT:lenOfData);
u = u(lenOUT:lenOfData);

figure(1)
    subplot(311)
        plot(time,u)
            title('Akèní zásah == výstup z regulátoru')
            xlabel('iterace (k)')
            ylabel('u(k)')
            xlim([0,time(end)])
            grid on
    subplot(312)
        plot(time,y)
            title('Regulovaná velièina == výstup ze soustavy')
            xlabel('iterace (k)')
            ylabel('y(k)')
            xlim([0,time(end)])
            grid on
    subplot(313)
        plot(time,e)
            title('Regulaèní odchylka == w(k) - y(k)')
            xlabel('iterace (k)')
            ylabel('e(k)')
            xlim([0,time(end)])
            grid on
        
%%
% figure(2)
%     step(c2d(tf(cit,jm),T,'zoh'))
%     hold on
%     plot(time,y,'-r')
     