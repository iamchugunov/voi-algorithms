function [d] = dP2dTdvz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdT(X,k,post,config);
    d = 2*(dPdvz(X,k,post,config)*dPdT(X,k,post,config) + P_t(X, k, post, config)*dPdTdvz(X,k,post,config));
end

