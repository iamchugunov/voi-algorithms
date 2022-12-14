function [d] = dP2ddtdvz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPddt(X,k,post,config);
    d = 2*(dPdvz(X,k,post,config)*dPddt(X,k,post,config) + P_t(X, k, post, config)*dPddtdvz(X,k,post,config));
end

