function [d] = dP2daxdax(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdax(X,k,post,config);
    d = 2*(dPdax(X,k,post,config)*dPdax(X,k,post,config) + P_t(X, k, post, config)*dPdaxdax(X,k,post,config));
end

