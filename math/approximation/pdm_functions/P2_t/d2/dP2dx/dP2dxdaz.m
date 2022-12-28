function [d] = dP2dxdaz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
    d = 2*(dPdaz(X,k,post,config)*dPdx(X,k,post,config) + P_t(X, k, post, config)*dPdxdaz(X,k,post,config));
end

