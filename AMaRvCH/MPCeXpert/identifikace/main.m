close all
%% naètení dat ze soustavy
if ~exist('M','var')
    M = dlmread('Data_1.txt');
end

t = M(:,1);
y = M(:,2);
u = M(:,3);

y = y - min(y);

% figure(2)
%     plot(t,y,t,u)

%% zašumìní
noise = false;
if noise == true
    y = abs(y + 0.05*randn(length(y),1));
end

%% identifikace soustavy
[ki, Tis] = ident_strejc(t, u, y, noise);

%%
ki = 1.31;
Tis = [30 45];

%% výpoèet hodnot identifikované soustavy
denConv = convolve_Ti(Tis);  % konvoluce jmenovatele s èasovými konstantami Tis
sys = tf(ki,denConv);  % systém s zesílením ki a èasovými konstantami Tis
y_ident = lsim(sys,u,t);  % výpoèet hodnot systému

%% chyba
err = (y - y_ident).^2;
S2 = norm(y - y_ident);

%% vykreslení
% samotná data
figure(1)
    set(1,'DefaultlineLineWidth',1.5)
    plot(t, y);
    xlabel('èas (s)')
    ylabel('y (V)')
    title('Pøechodová charakteristika')
    grid on
    grid minor
    ylim([0,8])
    legend('namìøená data')

% porovnání s identifikací
figure(2)
    set(2,'DefaultlineLineWidth',1.5)
    plot(t, y);
    hold on
    plot(t,y_ident,'-.r');
    plot(t,err,'-g')
    hold off
    xlabel('èas (s)')
    ylabel('y (1)')
    title('Identifikace soustavy')
    grid on
    grid minor
    ylim([0,8])
    legend('namìøená data','identifikovaná soustava','kvadratická chyba aproximace')
    txt(1) = text(200,4,sprintf('k = %0.2f',ki));
    txt(2) = text(200,3,sprintf('T_1 = %u',Tis(1)));
    txt(3) = text(200,2,sprintf('T_2 = %u',Tis(2)));
    arrayfun(@(ti) set(ti,'Color','red'), txt)
    arrayfun(@(ti) set(ti,'FontSize',25), txt)

%% uložení
% export_fig(1,'../img/trans_char.pdf')
% export_fig(2,'../img/trans_char_ident.pdf')