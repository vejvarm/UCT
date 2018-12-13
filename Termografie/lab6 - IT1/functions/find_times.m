function ts = find_times(t, y, y_stable, wanted)

    if any(wanted < 0) || any(wanted > 1.0)
        errordlg('Jedna nebo více hodnot ve wanted je mimo rozsah [0,1]', ...
                 'Value Error')
        return
    end
    
    ts = zeros(1,length(wanted));
    
    for i = 1:length(wanted)
        ys = wanted(i)*y_stable;
        [~,idx] = min(abs(y - ys));
        ts(i) = t(idx);
    end

