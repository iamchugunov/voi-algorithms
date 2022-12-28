function [d] = dP2dydaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdy(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPdy(X,k,post,config) + P_t(X, k, post, config)*dPdydaz(X,k,post,config));
end

