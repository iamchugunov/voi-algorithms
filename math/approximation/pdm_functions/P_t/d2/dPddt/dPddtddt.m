function [d] = dPddtddt(X, k, post, config)
%     d = dRddt(X,k,post,config) + (k - 1);
    d = dRddtddt(X,k,post,config);
end

