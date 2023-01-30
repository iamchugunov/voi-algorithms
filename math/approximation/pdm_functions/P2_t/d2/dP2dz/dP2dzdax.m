function [d] = dP2dzdax(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdz(X,k,post,config);
    d = 2*(dPdax(X,k,post,config)*dPdz(X,k,post,config) + P_t(X, k, post, config)*dPdzdax(X,k,post,config));
end

