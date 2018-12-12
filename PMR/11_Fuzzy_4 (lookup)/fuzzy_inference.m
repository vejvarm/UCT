function fx = fuzzy_inference(x, rules, ys)
    % param x (float): hodnota/vektor hodnot na vstupn�m prostoru
    % param rules (cellarray): pravidla (cellarray fc� p��slu�nosti na vstupn�m prostoru)
    % param ys (cellarray): hodnoty na v�stupn�m prostoru (p��slu�ej�c� pravidl�m ve stejn�m po�ad�)
    
    % rozm�ry
    n_rules = length(rules);                       % po�et pravidel
%     n_mfs = cellfun(@(rule) length(rule), rules);  % po�et fc� p��slu�nosti v jednotliv�ch pravidlech
    n_mfs = length(rules{1});                      % po�et fc� p��slu�nosti v jednotliv�ch pravidlech
    n_inputs = length(x);                          % d�lka vstupn� �ady
    n_outputs = n_inputs - n_mfs + 1;              % d�lka v�stupn� �ady
    
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
    parfor i_rule=1:n_rules         % ��dky (pravidla)
       for i_output=1:n_outputs  % sloupce (p��slu�nosti pravidla)
          for i_mf=1:n_mfs       % pravidla
              mu(i_rule,i_output) = mu(i_rule,i_output)*...
                                    rules{i_rule}{i_mf}(x(i_output+i_mf-1));
          end
       end
    end
    
    fx = ys*mu./sum(mu);
end