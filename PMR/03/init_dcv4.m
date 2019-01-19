%% parametry
M = 1;
m = 0.5;
delta = 1;

%% simulace
sim('ekviv_prenos_dcv4')

%% vykreslen�
if ishandle(1)
    delete(get(1,'Children'))
end
figure(1)
    set(1,'DefaultlineLineWidth',2)
    plot(w.Time, w.Data, y.Time, y.Data)
    title(sprintf('Ekvivalentn� p�enos 2 rel� s mrtvou z�nou a hysterez� \n M=%.1f, m=%.1f, \\delta=%.1f', M, m, delta))
    xlabel('�as (s)')
    ylabel('vstup/v�stup')
    grid on
    grid minor
    legend('vstup (w)','v�stup (y)')

%% export
% saveas(1,'ekviv_prenos_dcv4.svg')
% export_fig(1,'ekviv_prenos_dcv4.pdf')