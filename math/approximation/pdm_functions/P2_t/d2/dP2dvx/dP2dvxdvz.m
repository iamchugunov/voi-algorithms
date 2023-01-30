function [d] = dP2dvxdvz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvx(X,k,post,config);
    d = 2*(dPdvz(X,k,post,config)*dPdvx(X,k,post,config) + P_t(X, k, post, config)*dPdvxdvz(X,k,post,config));
end

