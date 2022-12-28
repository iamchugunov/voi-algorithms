function [d] = dP2dydy(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdy(X,k,post,config);
    d = 2*(dPdy(X,k,post,config)*dPdy(X,k,post,config) + P_t(X, k, post, config)*dPdydy(X,k,post,config));
end

