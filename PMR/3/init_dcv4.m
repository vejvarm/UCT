%% parametry
M = 1;
m = 0.5;
delta = 1;

%% simulace
sim('ekviv_prenos_dcv4')

%% vykreslení
if ishandle(1)
    delete(get(1,'Children'))
end
figure(1)
    set(1,'DefaultlineLineWidth',2)
    plot(w.Time, w.Data, y.Time, y.Data)
    title(sprintf('Ekvivalentní pøenos 2 relé s mrtvou zónou a hysterezí \n M=%.1f, m=%.1f, \\delta=%.1f', M, m, delta))
    xlabel('èas (s)')
    ylabel('vstup/výstup')
    grid on
    grid minor
    legend('vstup (w)','výstup (y)')

%% export
% saveas(1,'ekviv_prenos_dcv4.svg')
% export_fig(1,'ekviv_prenos_dcv4.pdf')