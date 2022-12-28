function [d] = dP2dazdaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdaz(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPdaz(X,k,post,config) + P_t(X, k, post, config)*dPdazdaz(X,k,post,config));
end

