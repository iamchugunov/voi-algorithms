function [d] = dP2dTddt(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPdT(X,k,post,config);
    d = 2*(dPddt(X,k,post,config)*dPdT(X,k,post,config) + P_t(X, k, post, config)*dPdTddt(X,k,post,config));
end

