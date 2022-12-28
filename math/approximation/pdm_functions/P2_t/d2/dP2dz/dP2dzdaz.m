function [d] = dP2dzdaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdz(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPdz(X,k,post,config) + P_t(X, k, post, config)*dPdzdaz(X,k,post,config));
end

