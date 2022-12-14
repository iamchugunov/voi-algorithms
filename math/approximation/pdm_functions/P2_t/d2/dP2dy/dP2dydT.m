function [d] = dP2dydT(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdy(X,k,post,config);
    d = 2*(dPdT(X,k,post,config)*dPdy(X,k,post,config) + P_t(X, k, post, config)*dPdydT(X,k,post,config));
end

