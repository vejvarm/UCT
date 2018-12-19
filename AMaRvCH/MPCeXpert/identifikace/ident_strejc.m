function [k, T] = ident_strejc(t, u, y, noise)
    % t ... time samples of the data for identification
    % u ... value samples of the inputs for identification
    % y ... value samples of the outputs for identification
    % noise ... (boolean) if true, the system is expected to be noisy and
    % will be smoothed

    % length of gathered data for identification
    len = length(t);

    % reduce the noise in data by smoothing
    if noise
        y = smoothing(y);
        
        figure(1)
            hold on
            plot(t,y);
            hold off
    end
    
    % percentage of the length for the mean of last values
    percent_stable = round(0.1*len);
    y_stable = mean(y(end-percent_stable, end));

    %% the gain of the system
    k = y_stable/u(end);
    
    %% finding inflection point
    infl = find_inflection(t,y);
    
    %% finding Tu and Tn
    [Tu,Tn] = find_Tu_Tn(t,y,infl.idx,infl.t,y_stable);
    
    %% deciding which approximation to use
    tau = Tu/Tn;
    
    if tau < 0.1
        y_72 = 0.72*y_stable;
        [~,i1] = min(abs(y-y_72));
        t1 = t(i1);
        T12 = t1/1.2564;  % sum of T1 and T2
        t2 = 0.3574*T12;
        i2 = round(t2/mean(diff(t)));
        yi2 = round(y(i2),2);
        
        if yi2 >= 0.16 && yi2 <= 0.3
            method = 1;
        else
            method = 2;
        end        
    elseif tau >= 0.1
        method = 2;  % n-th order with identical time constants
    else
        throw("something went wrong")
    end
    
    if method == 1
        y2breaks = 0.3:-0.01:0.16;
        tau2breaks = [0, 0.023, 0.043, 0.063, 0.084, ...
                0.105, 0.128, 0.154, 0.183, 0.219, ...
                0.264, 0.322, 0.403, 0.538, 1];
        tau2 = interp1(y2breaks,tau2breaks,yi2,'linear');
        
        % final time constant values for method 1
        T(2) = T12/(tau2 + 1);
        T(1) = T12 - T(2);
    elseif method == 2
        % lookup table for yi and n values based on tau
        taubreaks = [0.104,0.218,0.319,0.410,0.493,0.570,0.642,0.709,0.773];
        ybreaks = [0.246, 0.327, 0.359, 0.371, 0.384, 0.394, 0.401, 0.407, 0.413];
        nbreaks = 2:10;
        yi = interp1(taubreaks,ybreaks,tau,'linear','extrap');
        n = round(interp1(taubreaks,nbreaks,tau,'linear','extrap'));
        ti = t(round(yi/mean(diff(y))));
        
        % final time constant values for method 2
        T = ti/(n-1)*ones(1,n);
    end
    
    
    

    