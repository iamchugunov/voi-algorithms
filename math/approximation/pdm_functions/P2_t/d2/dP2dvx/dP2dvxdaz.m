function [d] = dP2dvxdaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvx(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPdvx(X,k,post,config) + P_t(X, k, post, config)*dPdvxdaz(X,k,post,config));
end

