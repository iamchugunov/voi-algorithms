function [d] = dP2dxddt(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
    d = 2*(dPddt(X,k,post,config)*dPdx(X,k,post,config) + P_t(X, k, post, config)*dPdxddt(X,k,post,config));
end

