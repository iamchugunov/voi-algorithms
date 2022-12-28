function [d] = dP2dydax(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdy(X,k,post,config);
    d = 2*(dPdax(X,k,post,config)*dPdy(X,k,post,config) + P_t(X, k, post, config)*dPdydax(X,k,post,config));
end

