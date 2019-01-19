function y = fun(x)
    
    persistent P
    
    if ~isempty(P)
        'hello'
    end
    
    P = 1;
    
    y = P;
        