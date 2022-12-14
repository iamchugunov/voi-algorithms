function [d] = dP2dvxdax(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvx(X,k,post,config);
    d = 2*(dPdax(X,k,post,config)*dPdvx(X,k,post,config) + P_t(X, k, post, config)*dPdvxdax(X,k,post,config));
end

