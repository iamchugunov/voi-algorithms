function [d] = dP2ddtddt(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPddt(X,k,post,config);
    d = 2*(dPddt(X,k,post,config)*dPddt(X,k,post,config) + P_t(X, k, post, config)*dPddtddt(X,k,post,config));
end

