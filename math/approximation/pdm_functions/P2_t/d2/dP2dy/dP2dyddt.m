function [d] = dP2dyddt(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdy(X,k,post,config);
    d = 2*(dPddt(X,k,post,config)*dPdy(X,k,post,config) + P_t(X, k, post, config)*dPdyddt(X,k,post,config));
end

