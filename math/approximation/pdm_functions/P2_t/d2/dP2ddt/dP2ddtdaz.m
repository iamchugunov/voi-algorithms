function [d] = dP2ddtdaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPddt(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPddt(X,k,post,config) + P_t(X, k, post, config)*dPddtdaz(X,k,post,config));
end

