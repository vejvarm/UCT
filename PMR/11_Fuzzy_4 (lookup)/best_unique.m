function [unq_idxs, unq_vals, unq_ys] = best_unique(idxs,vals,ys)
    % param idxs (array): indexy pravidel
    % param vals (array): hodnoty p��slu�nost� pravidel
    % param ys (array): singletony na v�stupu pravidel
    
    if iscell(idxs)
        idxs = cell2mat(idxs);
    end
    
    if iscell(vals)
        vals = cell2mat(vals);
    end
    
    if iscell(ys)
        ys = cell2mat(ys);
    end
   
    % inicializace
    unq_idxs = zeros(max(idxs),1);
    unq_vals = zeros(size(unq_idxs));
    unq_ys = zeros(size(unq_idxs));
    
    % nalezen� nejlep��ch (nejvy��� p��slu�nost) unik�tn�ch pravidel
    for i = 1:length(idxs)
        if vals(i) > unq_vals(idxs(i))
            unq_idxs(idxs(i)) = idxs(i);
            unq_vals(idxs(i)) = vals(i);
            unq_ys(idxs(i)) = ys(i);
        end
    end
    
    % odstran�n� nulov�ch hodnot
    unq_idxs = nonzeros(unq_idxs);
    unq_vals = nonzeros(unq_vals);
    unq_ys = nonzeros(unq_ys);