close all
clear

k = 0.5;                    % smernice primky nelinearni casti
w = linspace(0,5,10000);    % frekvence pro vykresleni frekv. char.

% soustava
Gj = 1./(1i*w.*(2i*w + 1).*(1i*w + 1).^2.*(0.5i*w + 1));

% vypocet realne a imaginarni casti
GjRe = real(Gj);
GjIm = imag(Gj);
    
% uprava imaginarni casti
GjIm_new = w.*GjIm;

% popovova primka
q = 3;               % prevracena hodnota smernice Popovovy primky
y = (GjRe + 1/k)/q;  % rovnice Popovovy primky

% vykresleni
figure(1)
    set(1,'DefaultLineLineWidth',2)
    plot(GjRe, GjIm);      % Frekvencni charakteristika
    hold on
    plot(GjRe, GjIm_new);  % Modifikovana frekvencni charakteristika
    plot(GjRe, y);         % Popovova primka
    hold off
    ylim([-1,0.5])
    title('Vysetreni stability Popovovym kriteriem')
    xlabel('Re')
    ylabel('Im')
    legend('G(j\omega)', 'G*(j\omega)', strcat('Popovova primka (q=',num2str(q),')'))
    grid on
    grid minor