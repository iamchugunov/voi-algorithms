function [d] = dP2dvydaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvy(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPdvy(X,k,post,config) + P_t(X, k, post, config)*dPdvydaz(X,k,post,config));
end

