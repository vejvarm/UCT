function [tspan_unq, temp_unq] = load_optris(filename)
    if ~exist('data','var')
        data = tdfread(filename);
    end

    %% pøevod teploty na èíselné hodnoty
    temp = arrayfun(@(x) strrep(x,',','.'), data.Temp);  % pøevod z desetinné èárky na teèku
    temp = str2num(temp);  % pøevod na èíselné hodnoty

    %% pøevod èasového sloupce na sekundy
    len = length(temp);
    tspan = zeros(len,1);
    for i = 1:len
        s = split(data.Time(i,:),':');  % rozdìlení u dvojteèek
        tspan(i) = str2double(s{1})*3600 + ...  % hodiny
                   str2double(s{2})*60 + ...    % minuty
                   str2double(s{3});            % sekundy
    end

    %% nalezení unikátních hodnot
    [tspan_unq, ia, ~] = unique(tspan);

    %% zprùmìrování hodnot teploty podle unikátních hodnot
    Nunq = length(ia);
    temp_unq = zeros(Nunq,1);

    for i = 1:Nunq-1
        temp_unq(i) = mean(temp(ia(i):ia(i+1)-1));
    end

    % zbytek hodnot
    temp_unq(Nunq) = mean(temp(ia(end):end));