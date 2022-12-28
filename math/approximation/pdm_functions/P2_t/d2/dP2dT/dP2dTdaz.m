function [d] = dP2dTdaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdT(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPdT(X,k,post,config) + P_t(X, k, post, config)*dPdTdaz(X,k,post,config));
end

