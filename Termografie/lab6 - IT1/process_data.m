addpath('./functions/')
close all

%% na�ten� dat z Optris Connect (Pyrometr)
if ~exist('optris','var')
    [optris.time, optris.temp] = load_optris('./data/optris.dat');
end

%% na�ten� dat z LabView (odporov� platinov� teplom�r)
if ~exist('Pt','var')
    [Pt.time, Pt.temp] = load_platinum('./data/val_1.lvm');
end

%% dopln�n� min teploty na za��tek optris, aby m�ly oba vektory stejnou d�lku
difference = length(Pt.time) - length(optris.time);
optris.time = [zeros(difference,1) ; optris.time];
optris.temp = [min(optris.temp)*ones(difference,1) ; optris.temp];

%% v�po�et T90
wanted = 0.9;
optris.T90 = find_times(optris.time, optris.temp, optris.temp(end), wanted);
Pt.T90 = find_times(Pt.time, Pt.temp, Pt.temp(end), wanted);

%% vykreslen�
figure(1)
    plot(optris.time, optris.temp, Pt.time, Pt.temp, 'LineWidth', 1.5)
    xlabel('�as (s)')
    ylabel('teplota (�C)')
    title('Porovn�n� dynamiky Pyrometru a Pt teplom�ru')
    legend('teplota nam��en� pyrometrem', 'teplota nam��en� Pt teplom�rem')
    grid on
    grid minor
    xlim([0, optris.time(end)])
    
% ulo�en� grafu
% export_fig(1,'./img/grafOptrisPt.pdf');
% export_fig(1,'./img/grafOptrisPt.png','-r300');


%% export do excelu
% xlswrite('./data/processed_data.xlsx',[{'optris �as', 'optris teplota', 'Pt �as', 'Pt teplota'}; ...
%                                        num2cell([optris.time, optris.temp, Pt.time, Pt.temp])])

    