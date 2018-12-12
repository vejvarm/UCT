function y = Fs(t,u,y0)

    if nargin == 2
        y0 = 0;
    end

    Ks = 0.1/(u-1)^2;
    y = y0 + (Ks - Ks*exp(-t/3) - (Ks*t*exp(-t/3))/3 - (Ks*t^2*exp(-t/3))/18)*u;

