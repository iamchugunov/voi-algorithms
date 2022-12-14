function [d] = dP2dTdvx(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdT(X,k,post,config);
    d = 2*(dPdvx(X,k,post,config)*dPdT(X,k,post,config) + P_t(X, k, post, config)*dPdTdvx(X,k,post,config));
end

