clear 
close all

% sys = tf(1,[3 1 0]);

w = linspace(0,10,1000);
ReG = -3./(9*w.^2 + 1);
Im = (-1./(9*w.^3 + w));
ImG = w.*Im;

%% OR
Gs = 1./(1i*w.*(3*1i*w + 1));
ReGs = real(Gs);
ImGs = imag(Gs);

%%
figure(1)
    plot(ReGs,ImGs);
    hold on
    plot(ReG,ImG,'-r');
%     xlim([-0.5,0.1]);
    ylim([-5,5]);