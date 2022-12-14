function [d] = dP2dzdvx(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdz(X,k,post,config);
    d = 2*(dPdvx(X,k,post,config)*dPdz(X,k,post,config) + P_t(X, k, post, config)*dPdzdvx(X,k,post,config));
end

