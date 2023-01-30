function [d] = dP2dTdax(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdT(X,k,post,config);
    d = 2*(dPdax(X,k,post,config)*dPdT(X,k,post,config) + P_t(X, k, post, config)*dPdTdax(X,k,post,config));
end

