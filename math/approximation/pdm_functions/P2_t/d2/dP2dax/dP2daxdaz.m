function [d] = dP2daxdaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdax(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPdax(X,k,post,config) + P_t(X, k, post, config)*dPdaxdaz(X,k,post,config));
end

