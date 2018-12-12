function y = average_input(s,n,T)
    % s ... objekt daq acquisition
    % n ... po�et zpr�m�rovan�ch vstup�
    % T ... perioda vzorkov�n� po zpr�m�rov�n� hodnot
    
    data = zeros(1,n);
    tp = T/n;  % interval pauzy mezi sb�rem dat
    
    for i = 1:n
        data(i) = inputSingleScan(s);
        pause(tp);
    end
    
    y = mean(data);