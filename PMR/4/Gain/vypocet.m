syms u s t Ks

y = 0.1/(u-1);
K = diff(y);
T = 3;

Fs = Ks/(T*s + 1)^3;

ys = ilaplace(Fs/s); % prechodova charakteristika