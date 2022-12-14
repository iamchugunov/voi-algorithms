function [d] = dP2ddtdvy(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPddt(X,k,post,config);
    d = 2*(dPdvy(X,k,post,config)*dPddt(X,k,post,config) + P_t(X, k, post, config)*dPddtdvy(X,k,post,config));
end

