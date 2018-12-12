function sig = gauss_sigma(x,y,c)
    sig = sqrt(-(x-c)^2/(2*log(y)));
end