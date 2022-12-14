function [d] = dP2daydaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPday(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPday(X,k,post,config) + P_t(X, k, post, config)*dPdaydaz(X,k,post,config));
end

