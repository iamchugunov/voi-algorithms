function [d] = dPdTday(X, k, post, config)
%     d = dRdT(X,k,post,config) + 1;
    d = dRdTdd(X,k,post,config);
end

