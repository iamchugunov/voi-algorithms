function [d] = dP2dTdvy(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdT(X,k,post,config);
    d = 2*(dPdvy(X,k,post,config)*dPdT(X,k,post,config) + P_t(X, k, post, config)*dPdTdvy(X,k,post,config));
end

