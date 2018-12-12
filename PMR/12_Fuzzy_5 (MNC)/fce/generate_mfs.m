function mfs = generate_mfs(centers,shape)
    
    correct_shapes = {'gauss','triang'};

    if nargin == 1
        shape = correct_shapes{1};
    elseif nargin == 2
        if ~any(cellfun(@(x) strcmp(x,shape),correct_shapes))
           shape = correct_shapes{1};
           warndlg('neznámá hodnota parametru "shape", implicitnì volím "gauss"')
        end
    else
        errordlg('Nesprávný poèet vstupních parametrù.')
        return
    end
    
    n_mfs = length(centers);
    mfs = cell(n_mfs,1);
    dcenters = mean(diff(centers));
    
    for i = 1:n_mfs
        if strcmp(shape,'gauss')
            sig = gauss_sigma(centers(i) + dcenters/2,0.5,centers(i));
            mfs{i} = @(xin) gaussmf(xin,[sig centers(i)]);  % gaussovky pravidel jako funkce 
        elseif strcmp(shape,'triang')
            mfs{i} = @(xin) trimf(xin, [centers(i) - dcenters centers(i) centers(i) + dcenters]);  % trojúhelníky pravidel jako funkce 
        end
    end