function [d] = dP2dxdy(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
    d = 2*(dPdy(X,k,post,config)*dPdx(X,k,post,config) + P_t(X, k, post, config)*dPdxdy(X,k,post,config));
end

