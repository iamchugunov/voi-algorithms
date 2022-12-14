function [d] = dP2dxdvz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
    d = 2*(dPdvz(X,k,post,config)*dPdx(X,k,post,config) + P_t(X, k, post, config)*dPdxdvz(X,k,post,config));
end

