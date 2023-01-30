function [d] = dPddtdvz(X, k, post, config)
%     d = dRddt(X,k,post,config) + (k - 1);
    d = dRddtdvz(X,k,post,config);
end

