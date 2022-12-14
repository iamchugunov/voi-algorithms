function [d] = dP2dydvz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdy(X,k,post,config);
    d = 2*(dPdvz(X,k,post,config)*dPdy(X,k,post,config) + P_t(X, k, post, config)*dPdydvz(X,k,post,config));
end

