function [d] = dP2dxdax(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
    d = 2*(dPdax(X,k,post,config)*dPdx(X,k,post,config) + P_t(X, k, post, config)*dPdxdax(X,k,post,config));
end

