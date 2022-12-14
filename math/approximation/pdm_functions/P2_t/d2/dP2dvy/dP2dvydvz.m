function [d] = dP2dvydvz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvy(X,k,post,config);
    d = 2*(dPdvz(X,k,post,config)*dPdvy(X,k,post,config) + P_t(X, k, post, config)*dPdvydvz(X,k,post,config));
end

