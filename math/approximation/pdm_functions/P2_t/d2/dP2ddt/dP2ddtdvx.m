function [d] = dP2ddtdvx(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPddt(X,k,post,config);
    d = 2*(dPdvx(X,k,post,config)*dPddt(X,k,post,config) + P_t(X, k, post, config)*dPddtdvx(X,k,post,config));
end

