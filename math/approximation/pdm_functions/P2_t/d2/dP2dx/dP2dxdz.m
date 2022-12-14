function [d] = dP2dxdz(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
    d = 2*(dPdz(X,k,post,config)*dPdx(X,k,post,config) + P_t(X, k, post, config)*dPdxdz(X,k,post,config));
end

