function [d] = dP2dzdvy(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdz(X,k,post,config);
    d = 2*(dPdvy(X,k,post,config)*dPdz(X,k,post,config) + P_t(X, k, post, config)*dPdzdvy(X,k,post,config));
end

