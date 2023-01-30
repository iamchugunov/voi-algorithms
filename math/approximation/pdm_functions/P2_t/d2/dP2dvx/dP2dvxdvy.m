function [d] = dP2dvxdvy(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvx(X,k,post,config);
    d = 2*(dPdvy(X,k,post,config)*dPdvx(X,k,post,config) + P_t(X, k, post, config)*dPdvxdvy(X,k,post,config));
end

