function [d] = dP2dxday(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdx(X,k,post,config);
    d = 2*(dPday(X,k,post,config)*dPdx(X,k,post,config) + P_t(X, k, post, config)*dPdxday(X,k,post,config));
end

