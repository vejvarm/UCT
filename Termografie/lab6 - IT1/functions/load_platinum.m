function [time, temp] = load_platinum(filename)
    %% pøeètení tab delimited souboru s desetinnými èárkami
    fid = fopen(filename,'rb');
    strings = textscan(fid, '%s %s');
    fclose(fid);

    %% pøevod na desetinné teèky
    strings = cellfun(@(s) strrep(s,',','.'), strings, 'UniformOutput',false);

    %% pøevod na èíselné hodnoty
    time = cellfun(@(s) str2num(s), strings{1});
    temp = cellfun(@(s) str2num(s), strings{2});