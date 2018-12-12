function fx = fuzzy_inference_v2(x, rules, ys, delay_idxs)
    % param x (float): hodnota/vektor hodnot na vstupním prostoru
    % param rules (cellarray): pravidla (cellarray fcí pøíslušnosti na vstupním prostoru)
    % param ys (cellarray): hodnoty na výstupním prostoru (pøíslušející pravidlùm ve stejném poøadí)
    
    % extrémy indexù hodnot, ze kterých predikujeme
    min_delay = min(delay_idxs);
    max_delay = max(delay_idxs);
    
    % rozmìry
    n_rules = length(rules);                       % poèet pravidel
    n_ifs = length(rules{1});                      % poèet fcí pøíslušnosti v jednotlivých pravidlech 
    n_inputs = length(x);                          % délka vstupní øady
    n_outputs = n_inputs - max_delay + 1;          % délka výstupní øady
    
    % inicializace
    mu = ones(n_rules,n_outputs);
%     y = zeros(size(mu));
    
    % pøevod x na sloupcový vektor (pokud je øádkový)
    if isrow(x)
        x = x';
    end
    
    % pøevod ys z cellarray na øádkový vektor
    if iscell(ys)
        ys = cell2mat(ys);
    end
    % pøevod ys ze sloupcového vektoru na øádkový
    if iscolumn(ys)
       ys = ys'; 
    end
    
    % výpoèet pøíslušností
    for i_rule=1:n_rules      % øádky (pravidla)
       for i_output=1:n_outputs  % sloupce (pøíslušnosti pravidla)
          for i_mf=1:n_ifs       % pravidla
              delay_idx = max_delay - delay_idxs(i_mf) + i_output;
              mu(i_rule,i_output) = mu(i_rule,i_output)*...
                                    rules{i_rule}{i_mf}(x(delay_idx));
          end
       end
    end
    
    fx = ys*mu./sum(mu);
end