function [d] = dP2dvzdax(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvz(X,k,post,config);
    d = 2*(dPdax(X,k,post,config)*dPdvz(X,k,post,config) + P_t(X, k, post, config)*dPdvzdax(X,k,post,config));
end

