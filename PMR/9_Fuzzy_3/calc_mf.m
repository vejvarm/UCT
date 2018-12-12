function mu = calc_mf(x,centers,widths)
    
    mu = zeros(size(centers));

    for i = 1:length(centers)
        mu(i) = mf(x,centers(i),widths(i));
    end