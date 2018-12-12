function y = average_input(s,n,T)
    % s ... objekt daq acquisition
    % n ... poèet zprùmìrovaných vstupù
    % T ... perioda vzorkování po zprùmìrování hodnot
    
    data = zeros(1,n);
    tp = T/n;  % interval pauzy mezi sbìrem dat
    
    for i = 1:n
        data(i) = inputSingleScan(s);
        pause(tp);
    end
    
    y = mean(data);