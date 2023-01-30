function [d] = dP2dydvx(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdy(X,k,post,config);
    d = 2*(dPdvx(X,k,post,config)*dPdy(X,k,post,config) + P_t(X, k, post, config)*dPdydvx(X,k,post,config));
end

