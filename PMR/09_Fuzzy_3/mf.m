function y = mf(x,b,w)
    a = b-w/2;
    c = b+w/2;
    y = max(min((x-a)/(b-a),(c-x)/(c-b)),0);
    