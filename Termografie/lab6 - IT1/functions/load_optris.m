function [tspan_unq, temp_unq] = load_optris(filename)
    if ~exist('data','var')
        data = tdfread(filename);
    end

    %% p�evod teploty na ��seln� hodnoty
    temp = arrayfun(@(x) strrep(x,',','.'), data.Temp);  % p�evod z desetinn� ��rky na te�ku
    temp = str2num(temp);  % p�evod na ��seln� hodnoty

    %% p�evod �asov�ho sloupce na sekundy
    len = length(temp);
    tspan = zeros(len,1);
    for i = 1:len
        s = split(data.Time(i,:),':');  % rozd�len� u dvojte�ek
        tspan(i) = str2double(s{1})*3600 + ...  % hodiny
                   str2double(s{2})*60 + ...    % minuty
                   str2double(s{3});            % sekundy
    end

    %% nalezen� unik�tn�ch hodnot
    [tspan_unq, ia, ~] = unique(tspan);

    %% zpr�m�rov�n� hodnot teploty podle unik�tn�ch hodnot
    Nunq = length(ia);
    temp_unq = zeros(Nunq,1);

    for i = 1:Nunq-1
        temp_unq(i) = mean(temp(ia(i):ia(i+1)-1));
    end

    % zbytek hodnot
    temp_unq(Nunq) = mean(temp(ia(end):end));