function [d] = dP2ddtdax(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPddt(X,k,post,config);
    d = 2*(dPdax(X,k,post,config)*dPddt(X,k,post,config) + P_t(X, k, post, config)*dPddtdax(X,k,post,config));
end

