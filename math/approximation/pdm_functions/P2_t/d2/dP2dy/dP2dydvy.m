function [d] = dP2dydvy(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdy(X,k,post,config);
    d = 2*(dPdvy(X,k,post,config)*dPdy(X,k,post,config) + P_t(X, k, post, config)*dPdydvy(X,k,post,config));
end

