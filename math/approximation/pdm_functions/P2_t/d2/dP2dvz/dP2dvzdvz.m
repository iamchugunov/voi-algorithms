function [d] = dP2dvzdvz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvz(X,k,post,config);
    d = 2*(dPdvz(X,k,post,config)*dPdvz(X,k,post,config) + P_t(X, k, post, config)*dPdvzdvz(X,k,post,config));
end

