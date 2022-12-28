function [d] = dP2dvxday(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdvx(X,k,post,config);
    d = 2*(dPday(X,k,post,config)*dPdvx(X,k,post,config) + P_t(X, k, post, config)*dPdvxday(X,k,post,config));
end

