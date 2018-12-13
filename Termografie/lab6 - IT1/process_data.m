addpath('./functions/')
close all

%% naètení dat z Optris Connect (Pyrometr)
if ~exist('optris','var')
    [optris.time, optris.temp] = load_optris('./data/optris.dat');
end

%% naètení dat z LabView (odporový platinový teplomìr)
if ~exist('Pt','var')
    [Pt.time, Pt.temp] = load_platinum('./data/val_1.lvm');
end

%% doplnìní min teploty na zaèátek optris, aby mìly oba vektory stejnou délku
difference = length(Pt.time) - length(optris.time);
optris.time = [zeros(difference,1) ; optris.time];
optris.temp = [min(optris.temp)*ones(difference,1) ; optris.temp];

%% výpoèet T90
wanted = 0.9;
optris.T90 = find_times(optris.time, optris.temp, optris.temp(end), wanted);
Pt.T90 = find_times(Pt.time, Pt.temp, Pt.temp(end), wanted);

%% vykreslení
figure(1)
    plot(optris.time, optris.temp, Pt.time, Pt.temp, 'LineWidth', 1.5)
    xlabel('èas (s)')
    ylabel('teplota (°C)')
    title('Porovnání dynamiky Pyrometru a Pt teplomìru')
    legend('teplota namìøená pyrometrem', 'teplota namìøená Pt teplomìrem')
    grid on
    grid minor
    xlim([0, optris.time(end)])
    
% uložení grafu
% export_fig(1,'./img/grafOptrisPt.pdf');
% export_fig(1,'./img/grafOptrisPt.png','-r300');


%% export do excelu
% xlswrite('./data/processed_data.xlsx',[{'optris èas', 'optris teplota', 'Pt èas', 'Pt teplota'}; ...
%                                        num2cell([optris.time, optris.temp, Pt.time, Pt.temp])])

    