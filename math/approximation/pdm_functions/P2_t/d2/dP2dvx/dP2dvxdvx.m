function [d] = dP2dvxdvx(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvx(X,k,post,config);
    d = 2*(dPdvx(X,k,post,config)*dPdvx(X,k,post,config) + P_t(X, k, post, config)*dPdvxdvx(X,k,post,config));
end

