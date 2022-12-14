function [d] = dPddtdax(X, k, post, config)
%     d = dRddt(X,k,post,config) + (k - 1);
    d = dRddtdax(X,k,post,config);
end

