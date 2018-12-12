function ys = smoothing(y)
    ys = smooth(y,20,'sgolay',3);
    ys = smooth(ys,0.1,'rloess');
        