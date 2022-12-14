function [d] = dPddtdvy(X, k, post, config)
%     d = dRddt(X,k,post,config) + (k - 1);
    d = dRddtdvy(X,k,post,config);
end

