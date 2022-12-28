function [d] = dP2dzddt(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdz(X,k,post,config);
    d = 2*(dPddt(X,k,post,config)*dPdz(X,k,post,config) + P_t(X, k, post, config)*dPdzddt(X,k,post,config));
end

