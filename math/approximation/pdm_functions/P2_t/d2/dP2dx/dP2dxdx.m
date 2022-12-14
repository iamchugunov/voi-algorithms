function [d] = dP2dxdx(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
    d = 2*(dPdx(X,k,post,config)*dPdx(X,k,post,config) + P_t(X, k, post, config)*dPdxdx(X,k,post,config));
end

