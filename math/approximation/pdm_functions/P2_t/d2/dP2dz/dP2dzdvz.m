function [d] = dP2dzdvz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdz(X,k,post,config);
    d = 2*(dPdvz(X,k,post,config)*dPdz(X,k,post,config) + P_t(X, k, post, config)*dPdzdvz(X,k,post,config));
end

