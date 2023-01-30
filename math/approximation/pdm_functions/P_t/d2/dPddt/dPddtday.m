function [d] = dPddtday(X, k, post, config)
%     d = dRddt(X,k,post,config) + (k - 1);
    d = dRddtday(X,k,post,config);
end

