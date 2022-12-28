function [d] = dPddtdaz(X, k, post, config)
%     d = dRddt(X,k,post,config) + (k - 1);
    d = dRddtdaz(X,k,post,config);
end

