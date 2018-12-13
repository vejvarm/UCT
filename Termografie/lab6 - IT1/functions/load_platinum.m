function [time, temp] = load_platinum(filename)
    %% p�e�ten� tab delimited souboru s desetinn�mi ��rkami
    fid = fopen(filename,'rb');
    strings = textscan(fid, '%s %s');
    fclose(fid);

    %% p�evod na desetinn� te�ky
    strings = cellfun(@(s) strrep(s,',','.'), strings, 'UniformOutput',false);

    %% p�evod na ��seln� hodnoty
    time = cellfun(@(s) str2num(s), strings{1});
    temp = cellfun(@(s) str2num(s), strings{2});