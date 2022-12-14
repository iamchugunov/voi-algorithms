function [d] = dP2ddtday(X, k, post, config)
%     Pd = 2 * P_t(X, k, post, config) * dPddt(X,k,post,config);
    d = 2*(dPday(X,k,post,config)*dPddt(X,k,post,config) + P_t(X, k, post, config)*dPddtday(X,k,post,config));
end

