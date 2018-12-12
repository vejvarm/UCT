function fx = fuzzy_inference(x, rules, ys)
    % param x (float): hodnota/vektor hodnot na vstupním prostoru
    % param rules (cellarray): pravidla (cellarray fcí pøíslušnosti na vstupním prostoru)
    % param ys (cellarray): hodnoty na výstupním prostoru (pøíslušející pravidlùm ve stejném poøadí)
    
    % rozmìry
    n_rules = length(rules);                       % poèet pravidel
%     n_mfs = cellfun(@(rule) length(rule), rules);  % poèet fcí pøíslušnosti v jednotlivých pravidlech
    n_mfs = length(rules{1});                      % poèet fcí pøíslušnosti v jednotlivých pravidlech
    n_inputs = length(x);                          % délka vstupní øady
    n_outputs = n_inputs - n_mfs + 1;              % délka výstupní øady
    
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
    parfor i_rule=1:n_rules         % øádky (pravidla)
       for i_output=1:n_outputs  % sloupce (pøíslušnosti pravidla)
          for i_mf=1:n_mfs       % pravidla
              mu(i_rule,i_output) = mu(i_rule,i_output)*...
                                    rules{i_rule}{i_mf}(x(i_output+i_mf-1));
          end
       end
    end
    
    fx = ys*mu./sum(mu);
end