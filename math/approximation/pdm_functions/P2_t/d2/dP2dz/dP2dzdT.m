function [d] = dP2dzdT(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdz(X,k,post,config);
    d = 2*(dPdT(X,k,post,config)*dPdz(X,k,post,config) + P_t(X, k, post, config)*dPdzdT(X,k,post,config));
end

