function [d] = dP2dvydvy(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvy(X,k,post,config);
    d = 2*(dPdvy(X,k,post,config)*dPdvy(X,k,post,config) + P_t(X, k, post, config)*dPdvydvy(X,k,post,config));
end

