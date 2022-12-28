function [d] = dP2dxdT(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
    d = 2*(dPdT(X,k,post,config)*dPdx(X,k,post,config) + P_t(X, k, post, config)*dPdxdT(X,k,post,config));
end

