function [d] = dP2dzdz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdz(X,k,post,config);
    d = 2*(dPdz(X,k,post,config)*dPdz(X,k,post,config) + P_t(X, k, post, config)*dPdzdz(X,k,post,config));
end

