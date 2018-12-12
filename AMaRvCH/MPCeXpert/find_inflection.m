function infl = find_inflection(t,y)
    % Estimate the 2nd deriv. by finite differences
%     d2y = diff(y,2);  
% 
%     % Find the root of d2y (inflection point of y) using FZERO
%     t_infl = fzero(@(T) interp1(t(2:end-1),d2y,T,'linear','extrap'),0);
%     y_infl = interp1(t,y,t_infl,'linear');
%     [~,i_infl] = min(abs(t - t_infl));

    % find first derivative of y 
    dy = diff(y)./diff(t);
    
    % find the index of maximum of dy
    [~, infl.idx] = max(dy);
    
    % time and value of the inflection
    infl.t = t(infl.idx);
    infl.y = y(infl.idx);