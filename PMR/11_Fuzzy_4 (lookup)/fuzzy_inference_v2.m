function fx = fuzzy_inference_v2(x, rules, ys, delay_idxs)
    % param x (float): hodnota/vektor hodnot na vstupn�m prostoru
    % param rules (cellarray): pravidla (cellarray fc� p��slu�nosti na vstupn�m prostoru)
    % param ys (cellarray): hodnoty na v�stupn�m prostoru (p��slu�ej�c� pravidl�m ve stejn�m po�ad�)
    
    % extr�my index� hodnot, ze kter�ch predikujeme
    min_delay = min(delay_idxs);
    max_delay = max(delay_idxs);
    
    % rozm�ry
    n_rules = length(rules);                       % po�et pravidel
    n_ifs = length(rules{1});                      % po�et fc� p��slu�nosti v jednotliv�ch pravidlech 
    n_inputs = length(x);                          % d�lka vstupn� �ady
    n_outputs = n_inputs - max_delay + 1;          % d�lka v�stupn� �ady
    
    % inicializace
    mu = ones(n_rules,n_outputs);
%     y = zeros(size(mu));
    
    % p�evod x na sloupcov� vektor (pokud je ��dkov�)
    if isrow(x)
        x = x';
    end
    
    % p�evod ys z cellarray na ��dkov� vektor
    if iscell(ys)
        ys = cell2mat(ys);
    end
    % p�evod ys ze sloupcov�ho vektoru na ��dkov�
    if iscolumn(ys)
       ys = ys'; 
    end
    
    % v�po�et p��slu�nost�
    for i_rule=1:n_rules      % ��dky (pravidla)
       for i_output=1:n_outputs  % sloupce (p��slu�nosti pravidla)
          for i_mf=1:n_ifs       % pravidla
              delay_idx = max_delay - delay_idxs(i_mf) + i_output;
              mu(i_rule,i_output) = mu(i_rule,i_output)*...
                                    rules{i_rule}{i_mf}(x(delay_idx));
          end
       end
    end
    
    fx = ys*mu./sum(mu);
end