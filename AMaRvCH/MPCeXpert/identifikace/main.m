close all
%% na�ten� dat ze soustavy
if ~exist('M','var')
    M = dlmread('Data_1.txt');
end

t = M(:,1);
y = M(:,2);
u = M(:,3);

y = y - min(y);

% figure(2)
%     plot(t,y,t,u)

%% za�um�n�
noise = false;
if noise == true
    y = abs(y + 0.05*randn(length(y),1));
end

%% identifikace soustavy
[ki, Tis] = ident_strejc(t, u, y, noise);

%%
ki = 1.31;
Tis = [30 45];

%% v�po�et hodnot identifikovan� soustavy
denConv = convolve_Ti(Tis);  % konvoluce jmenovatele s �asov�mi konstantami Tis
sys = tf(ki,denConv);  % syst�m s zes�len�m ki a �asov�mi konstantami Tis
y_ident = lsim(sys,u,t);  % v�po�et hodnot syst�mu

%% chyba
err = (y - y_ident).^2;
S2 = norm(y - y_ident);

%% vykreslen�
% samotn� data
figure(1)
    set(1,'DefaultlineLineWidth',1.5)
    plot(t, y);
    xlabel('�as (s)')
    ylabel('y (V)')
    title('P�echodov� charakteristika')
    grid on
    grid minor
    ylim([0,8])
    legend('nam��en� data')

% porovn�n� s identifikac�
figure(2)
    set(2,'DefaultlineLineWidth',1.5)
    plot(t, y);
    hold on
    plot(t,y_ident,'-.r');
    plot(t,err,'-g')
    hold off
    xlabel('�as (s)')
    ylabel('y (1)')
    title('Identifikace soustavy')
    grid on
    grid minor
    ylim([0,8])
    legend('nam��en� data','identifikovan� soustava','kvadratick� chyba aproximace')
    txt(1) = text(200,4,sprintf('k = %0.2f',ki));
    txt(2) = text(200,3,sprintf('T_1 = %u',Tis(1)));
    txt(3) = text(200,2,sprintf('T_2 = %u',Tis(2)));
    arrayfun(@(ti) set(ti,'Color','red'), txt)
    arrayfun(@(ti) set(ti,'FontSize',25), txt)

%% ulo�en�
% export_fig(1,'../img/trans_char.pdf')
% export_fig(2,'../img/trans_char_ident.pdf')