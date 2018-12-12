function [Tu,Tn] = find_Tu_Tn(t,y,i_infl,t_infl,y_stable)
    dy = diff(y)./diff(t);
    tang=(t-t_infl)*dy(i_infl)+y(i_infl); % tangent to y at t_infl
    
    [~,i_tang_0] = min(abs(tang));
    [~,i_tang_k] = min(abs(tang-y_stable));
    Tu = t(i_tang_0) - t(1);
    Tn = t(i_tang_k) - t(i_tang_0);