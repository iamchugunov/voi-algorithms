function [d] = dP2dTdT(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdT(X,k,post,config);
    d = 2*(dPdT(X,k,post,config)*dPdT(X,k,post,config) + P_t(X, k, post, config)*dPdTdT(X,k,post,config));
end

