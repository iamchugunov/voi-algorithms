function [d] = dPddtdvx(X, k, post, config)
%     d = dRddt(X,k,post,config) + (k - 1);
    d = dRddtdvx(X,k,post,config);
end

