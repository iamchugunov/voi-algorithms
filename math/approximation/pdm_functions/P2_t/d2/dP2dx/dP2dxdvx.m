function [d] = dP2dxdvx(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
    d = 2*(dPdvx(X,k,post,config)*dPdx(X,k,post,config) + P_t(X, k, post, config)*dPdxdvx(X,k,post,config));
end

