function [d] = dP2dvzdaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvz(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPdvz(X,k,post,config) + P_t(X, k, post, config)*dPdvzdaz(X,k,post,config));
end

